Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272926AbTHIRUw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275343AbTHIRUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:20:52 -0400
Received: from [203.185.132.65] ([203.185.132.65]:528 "EHLO
	opensource.thai.net") by vger.kernel.org with ESMTP id S275307AbTHIRT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:19:58 -0400
Message-ID: <4092.127.0.0.1.1060449592.squirrel@mail.opentle.org>
Date: Sun, 10 Aug 2003 00:19:52 +0700 (ICT)
Subject: Fail mount root before USB device registered during boot
From: "Phattanon Duangdara" <sf_alpha@opentle.org>
To: linux-kernel@vger.kernel.org
Reply-To: sf_alpha@opentle.org
X-Mailer: SquirrelMail (version 1.3.2)
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using boot 2.6.0-test2 and 2.4.21 and last prepatch. I try to use
initrd to load needed USB and SCSI modules and also buit these modules
into kernel but booting from some USB devices doesn't work because USB
mass stroage device was successfully registered after kernel trying to
mount root duing boot.

I think some USB devices may have slow response of resetting device (I'm
using Cypress AT2 IDE-to-USB Bridge).

I don't know it happened only in SMP system or not. I'm using SMP on P4
with HyperThreading Enabled.

Is there any way to solve this problem. Curreny I have to add sleep to
script in initrd to wait for USB device active. Or is this a bug ?

[TLWG] Thai Linux Working Group http://linux.thai.net
-- ^ Gentoo! Fresh, Flavour, Ever ^ --
