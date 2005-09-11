Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVIKM10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVIKM10 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 08:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVIKM10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 08:27:26 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23712 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964930AbVIKM10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 08:27:26 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [GIT PATCHES] final kbuild update before fix-only period
Date: Sun, 11 Sep 2005 15:26:57 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050910200347.GA3762@mars.ravnborg.org>
In-Reply-To: <20050910200347.GA3762@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509111526.58010.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 September 2005 23:03, Sam Ravnborg wrote:
> Hi Linus.
> 
> Please pull from:
> 	rsync://sync.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git
> 
> The updates are pushed to master.kernel.org - still waiting for
> mirroring to pick them up.
> 
> This update contains a fix with make O= for generic asm-offsets.h, plus
> additional patches from my queue.
> This clears my queue of pending patches for 2.6.14.
> 
> I will try to follow-up with all patches.

Hi Sam,

BUG()s etc which are using __FILE__ to get source filename
print horribly long names like

/.share/usr/src2/kernel/linux-2.6.13-mm2.src/drivers/net/.../some.c

if one builds kernel in separate object dir.
This is ugly and wastes space in kernel image. Any ideas how to fix this?
--
vda
