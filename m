Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVBGVmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVBGVmo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVBGVmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:42:43 -0500
Received: from ulysses.news.tiscali.de ([195.185.185.36]:782 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S261335AbVBGVmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:42:40 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: =?ISO-8859-15?Q?Heinz=2DJ=FCrgen?= Oertel <hj.oertel@surfeu.de>
Newsgroups: linux.kernel
Subject: Re: ioremap() and port of linux to MPC7400 based SBC (VME board)
Date: Mon, 07 Feb 2005 22:39:38 +0100
Organization: port GmbH
Message-ID: <cu8ncd$u6u$1@ulysses.news.tiscali.de>
References: <420767A1.2050300@here.com>
Reply-To: hj.oertel@surfeu.de
NNTP-Posting-Host: p213.54.133.149.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit
X-Trace: ulysses.news.tiscali.de 1107812557 30942 213.54.133.149 (7 Feb 2005 21:42:37 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Mon, 7 Feb 2005 21:42:37 +0000 (UTC)
User-Agent: KNode/0.8.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

him wrote:

> I have run into a problem I am having a hard time figuring out.
> 
> I have an MPC7400 SBC (PCI bus based) that has a device X residing
> at the following locations in memory:
> 
> 0x1860 0000 - 0x186f ffff     device control register space
> 0xb000 0000 - 0xbfff ffff     device memory space
> 
> Now assume for a moment that NOTHING special needs to be done to
> access either space once the system has booted and bus enumerator
> have set things up.
> 
> ioremap() of the first physical address returns a VALID virtual
> address  ... that I can read and write to. It works as expected
> because there are signature values at various offsets in the control
> register space.
> The virtual address returned is EQUAL to the physical address
> 
> ioremap() of the second physical address also returns what appears to
> be a VALID virtual address although WRITES go nowhere and READS return
> all ff's.
> The virtual address returned is 0xc100 0000
> 
> 
> 
> Now my question ... I have the source for the port. Where should I focus
> my efforts in trying to figure this out?
> 
> I have read the device drivers book and certain that I am following
> the rules.
> 
> I should also mention that there is an IO controller seperate from the
> MPC7400 that I use to verify that the device X control and memory exist
> in THAT physical range.
> 
> If Only I can access them through ioremap()
> 
> Thanks

No idea up to now, but what kernel, what linux? is it VM linux or uClinux?

Heinz
-- 

with best regards / mit freundlichen Grüßen

   Heinz-Jürgen Oertel
+===================================================================
| Heinz-Jürgen Oertel  port GmbH  http://www.port.de
| mailto:oe@port.de
| phone +49 345 77755-0     fax   +49 345 77755-20
| Regensburger Str. 7b,     D-06132 Halle/Saale,  Germany 
| CAN Wiki    http://www.CAN-Wiki.info
| Newsletter: http://www.port.de/engl/company/content/abo_form.html
+===================================================================
