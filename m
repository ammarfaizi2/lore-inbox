Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbUKZX5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUKZX5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbUKZX5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:57:13 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:35233 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263081AbUKZTmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:42:09 -0500
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125214524.GE2488@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101293918.5805.221.camel@desktop.cunninghams>
	 <20041125170718.GA1417@openzaurus.ucw.cz>
	 <1101418614.27250.21.camel@desktop.cunninghams>
	 <20041125214524.GE2488@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101419500.27250.41.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 08:51:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 08:45, Pavel Machek wrote:
> Hi!
> 
> > > And if you really want to make it changeable, pass major:minor from userland; once
> > > userland is running getting them is easy.
> > 
> > Yes, but that's also far uglier, and who thinks in terms of major and
> > minor numbers anyway? I think of my harddrive as /dev/sda, not 08:xx.
> > The parsing accepts majors and minors, of course, but shouldn't we make
> > these things easier to do, not harder? (Would we insist on using majors
> > and minors for root=?).
> 
> Kernel interface is not supposed to be "easy". root= has exception,
> that's init code, and you can't easily ls -al /dev at that point. If
> you want easy interface, create userland program that looks up
> minor/major in /dev/ and uses them.

That's a fair possibility, but is it really worth it when all we need to
do is make two routines not be init? We would still have to duplicate
some of this code elsewhere anyway, because we need to parse the major
and minor numbers.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

