Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVJ3TEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVJ3TEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVJ3TEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:04:45 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:28634 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932219AbVJ3TEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:04:45 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: madhu.subbaiah@wipro.com
Subject: Re: select() for delay.
Date: Sun, 30 Oct 2005 20:06:15 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <EE111F112BBFF24FB11DB557FA2E5BF301992F02@BLR-EC-MBX02.wipro.com>
In-Reply-To: <EE111F112BBFF24FB11DB557FA2E5BF301992F02@BLR-EC-MBX02.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510302006.15892.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maandag 24 Oktober 2005 12:55, madhu.subbaiah@wipro.com wrote:
 
> This is regarding select() system call.
> 
> Linux select() man page mentions " Some  code  calls  select with all
> three sets empty, n zero, and a non-null timeout as a fairly portable
> way to sleep  with  subsecond  precision".

When you make a change to a system call, you should always check
if the change makes sense for the 32 bit emulation path as well.

In this case, you should definitely do the same thing to both
sys_select and compat_sys_select if this is found worthwhile.
 
> This patch improves the sys_select() execution when used for delay. 

Please describe what aspect of the syscall is improved. Is this only
speeding up the execution for the delay case while slowing down
the normal case, or do the actual semantics improve?

	Arnd <><
