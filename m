Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265429AbUHHPFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbUHHPFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 11:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbUHHPFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 11:05:24 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:37034 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265429AbUHHPFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 11:05:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Date: Sun, 8 Aug 2004 10:05:14 -0500
User-Agent: KMail/1.6.2
Cc: Sascha Wilde <wilde@sha-bang.de>, "David N. Welton" <davidw@eidetix.com>,
       James Lamanna <jamesl@appliedminds.com>
References: <4112A626.1000706@appliedminds.com> <41133FE1.2040906@eidetix.com> <20040808121837.GA912@kenny.sha-bang.local>
In-Reply-To: <20040808121837.GA912@kenny.sha-bang.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408081005.14832.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 August 2004 07:18 am, Sascha Wilde wrote:
> On Fri, Aug 06, 2004 at 10:22:57AM +0200, David N. Welton wrote:
> > [ Re-added Sascha to the CC, as he's interested in this too. ]
> > 
> > James Lamanna wrote:
> > 
> > >Change i8042.c:62 to
> > >#define DEBUG
> > >And see what printk's you get on trying to reboot.
> > >i8042_command has a bunch in it that are turned off by default.
> 
> I just did some further testing, the problem here is exactly the same
> as Davids.  And thinking about the exact point of failure and that
> Davids reboot problem is related to the keyboard being attached or not
> I realized what causes the problems for me:
> 
> I have a keyboard attached to the PS/2 port, but my mouse is attached
> to USB.  So I pluged in a PS/2 mouse, and guess what?  The box
> rebooted!
> 
> Well, this is by no means a solution, but I think it's pretty clear
> now, what exactly causes the trouble.  Now we have to find out, why
> the i8042 code in 2.6.x breaks things on sertain hardware when there
> are not devices present in all ports, while in 2.4.x everything went
> well... 
> 

You could also try out the following scenario: remove your USB mouse and
_do not_ plug PS/2 one... What you might be seeing is another case of USB
Legacy emulation thingy getting in your way.
 
-- 
Dmitry
