Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUJGUIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUJGUIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUJGUIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:08:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:11440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267841AbUJGUH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:07:26 -0400
Date: Thu, 7 Oct 2004 13:05:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: serue@us.ibm.com, chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-Id: <20041007130530.5bcffa3c.akpm@osdl.org>
In-Reply-To: <20041007124221.D2357@build.pdx.osdl.net>
References: <1097094103.6939.5.camel@serge.austin.ibm.com>
	<1097094270.6939.9.camel@serge.austin.ibm.com>
	<20041006162620.4c378320.akpm@osdl.org>
	<20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com>
	<20041007124221.D2357@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Serge E. Hallyn (serue@us.ibm.com) wrote:
> > Attached is a new version of the bsdjail patch with the requested code
> > cleanups applied.
> 
> I noticed Andrew picked this up in -mm3, but that he had to do some diff
> cleanups (see the thread/rlim changes in his tree).  If you'd like Andrew
> to pick this up, it would be courteous to get the diff clean and
> building against his tree.

Nah, that's OK.  I can drop the old patch and pick up the new.

It's only when code is settling down into a final state that I get upset
about wholesale replacements.  Even then I'll just feed it through
interdiff.

> Andrew has cleanup here (__FUNCTION__ ,).  I just use __func__, anyway.

That's a workaround for the gcc-2.95 pasting bug.

__FUNCTION__ is preferred, actually.  Just for consistency, and so the
compiler will spit it out if someone tries to do compile-time string
concatenation with it.

