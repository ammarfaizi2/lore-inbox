Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265285AbUHHMSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUHHMSp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 08:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUHHMSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 08:18:45 -0400
Received: from mail1.kontent.de ([81.88.34.36]:38530 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265285AbUHHMSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 08:18:43 -0400
Date: Sun, 8 Aug 2004 14:18:37 +0200
From: Sascha Wilde <wilde@sha-bang.de>
To: "David N. Welton" <davidw@eidetix.com>
Cc: James Lamanna <jamesl@appliedminds.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040808121837.GA912@kenny.sha-bang.local>
References: <4112A626.1000706@appliedminds.com> <41133FE1.2040906@eidetix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41133FE1.2040906@eidetix.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 10:22:57AM +0200, David N. Welton wrote:
> [ Re-added Sascha to the CC, as he's interested in this too. ]
> 
> James Lamanna wrote:
> 
> >Change i8042.c:62 to
> >#define DEBUG
> >And see what printk's you get on trying to reboot.
> >i8042_command has a bunch in it that are turned off by default.

I just did some further testing, the problem here is exactly the same
as Davids.  And thinking about the exact point of failure and that
Davids reboot problem is related to the keyboard being attached or not
I realized what causes the problems for me:

I have a keyboard attached to the PS/2 port, but my mouse is attached
to USB.  So I pluged in a PS/2 mouse, and guess what?  The box
rebooted!

Well, this is by no means a solution, but I think it's pretty clear
now, what exactly causes the trouble.  Now we have to find out, why
the i8042 code in 2.6.x breaks things on sertain hardware when there
are not devices present in all ports, while in 2.4.x everything went
well... 

cheers 
sascha
-- 
>++++++[<+++++++++++>-]<+.>+++[<++++++>-]<.---.---------.++++++.++++.---------
-.+++++++++++.+++++.>+++++++[<-------->-]<-.>++++++[<+++++++>-]<+.--.+++..----
---.-.>++++++[<------>-]<.>++++[<+++++++++++++>-]<.------------.---.>++++++[<-
----->-]<-.>+++++[<+++++++>-]<.--.>+++[<++++++>-]<+.>++++++++[<--------->-]<--.
