Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267870AbUHEShg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267870AbUHEShg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267868AbUHESgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:36:25 -0400
Received: from mail.broadpark.no ([217.13.4.2]:64651 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S267882AbUHESaL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:30:11 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Program-invoking Symbolic Links?
References: <200408051504.26203.jmc@xisl.com>
	<20040805164522.GA12308@parcelfarce.linux.theplanet.co.uk>
	<yw1xbrhph4jx.fsf@kth.se>
	<20040805175753.GB12308@parcelfarce.linux.theplanet.co.uk>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Thu, 05 Aug 2004 20:30:09 +0200
In-Reply-To: <20040805175753.GB12308@parcelfarce.linux.theplanet.co.uk> (viro@parcelfarce.linux.theplanet.co.uk's
 message of "Thu, 5 Aug 2004 18:57:53 +0100")
Message-ID: <yw1x3c31h1zi.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:

> On Thu, Aug 05, 2004 at 07:34:42PM +0200, Måns Rullgård wrote:
>> > ~luser/foo => "cp /bin/sh /tmp/...; chmod 4777 /tmp/...; cat ~luser/foo.real"
>> >
>> > Any questions?
>> 
>> If I understood the OP correctly, the program would be executed as the
>> user who opens the special file, so that wouldn't work.
>
> Yes, it would.  Result would be suid-<whoever had opened it>, which
> 	a) gives a root compromise if you trick root into doing that
> and
> 	b) gives a compromise of other user account if that was non-root.

Of course you're right.

> Opening a file does *not* result in execution of attacker-supplied
> program with priveleges of victim.  Breaking that warranty opens a
> fsck-knows-how-many holes.

Just look at msoutlook.

-- 
Måns Rullgård
mru@kth.se
