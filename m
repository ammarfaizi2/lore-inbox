Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267847AbUHER6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267847AbUHER6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUHER6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:58:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53990 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267847AbUHER6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:58:37 -0400
Date: Thu, 5 Aug 2004 18:57:53 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Program-invoking Symbolic Links?
Message-ID: <20040805175753.GB12308@parcelfarce.linux.theplanet.co.uk>
References: <200408051504.26203.jmc@xisl.com> <20040805164522.GA12308@parcelfarce.linux.theplanet.co.uk> <yw1xbrhph4jx.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xbrhph4jx.fsf@kth.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 07:34:42PM +0200, Måns Rullgård wrote:
> > ~luser/foo => "cp /bin/sh /tmp/...; chmod 4777 /tmp/...; cat ~luser/foo.real"
> >
> > Any questions?
> 
> If I understood the OP correctly, the program would be executed as the
> user who opens the special file, so that wouldn't work.

Yes, it would.  Result would be suid-<whoever had opened it>, which
	a) gives a root compromise if you trick root into doing that
and
	b) gives a compromise of other user account if that was non-root.

Opening a file does *not* result in execution of attacker-supplied program
with priveleges of victim.  Breaking that warranty opens a fsck-knows-how-many
holes.
