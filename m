Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVCVNwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVCVNwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 08:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVCVNwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 08:52:36 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:5010 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261230AbVCVNwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:52:33 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Voodoo 3 2000 framebuffer problem
To: DervishD <lkml@dervishd.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Tue, 22 Mar 2005 14:57:07 +0100
References: <fa.cmkmtid.l6sdqh@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DDjsg-0000rS-0e@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <lkml@dervishd.net> wrote:

>     Linux Kernel 2.4.29, in a do-it-yourself linux box, equipped with
> an AGP Voodoo 3 2000 card, tdfx framebuffer support. I boot in vga
> mode 0x0f05, with parameter 'video=tdfx:800x600-32@100' and I get
> (correctly) 100x37 character grid. All of that is correct. What is
> not correct is the characters attributes, namely the 'blink'
> attribute.

Blinking a whole screen of text is much more expensive than a block cursor.
You'll want hardware support, e.g. some kind of double-buffering or using
240 colors just for that purpose in a 256 color mode.
(I would not implement that.)
