Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269632AbUJLLi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269632AbUJLLi5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbUJLLi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:38:57 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:14038 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269627AbUJLLig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:38:36 -0400
Message-ID: <b2fa632f04101204385c09459f@mail.gmail.com>
Date: Tue, 12 Oct 2004 17:08:32 +0530
From: Raj <inguva@gmail.com>
Reply-To: Raj <inguva@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Build problems with APM/Subarch type
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to build a 2.6.9-rc4. My box is an Intel P4.

Did all the configuration properly, except that i fumbled on the keyboard and
the option 'Subarchitecture Type' somehow got set to
'(SGI 320/540 Visual Workstation)'.

The build failed with an error 'Undefined reference to machine_real_restart'

It seems that , unless Subarch is PC-Compatible ( CONFIG_PC ) , 
CONFIG_X86_BIOS_REBOOT will not be set and thusly, reboot.c would not be
compiled.

( yeah, i know messing around with configs is suicidal, but.... )

Can this be fixed ?? At the very least, hide APM options #if !(CONFIG_PC) ??
-- 
######
raj
######
