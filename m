Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280712AbRKJUgq>; Sat, 10 Nov 2001 15:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280709AbRKJUgl>; Sat, 10 Nov 2001 15:36:41 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:530 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S280712AbRKJUgb>; Sat, 10 Nov 2001 15:36:31 -0500
Date: Sat, 10 Nov 2001 20:33:48 +0000
From: John Levon <moz@compsoc.man.ac.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: bcrl@redhat.com
Subject: Re: [RFT] final cur of tr based current for -ac8
Message-ID: <20011110203348.A98674@compsoc.man.ac.uk>
In-Reply-To: <20011110141440.C17437@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011110141440.C17437@redhat.com>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2001 at 02:14:40PM -0500, Benjamin LaHaise wrote:

> Here's hopefully the end of the experimental current games in -ac8.  This 
> one boots on UP and SMP unlike the last couple.  Widespread testing would 
> be appreciated, especially considering that 2.4.13-ac8 is unusable on x86 

Needs this :

--- kernel/ksyms.c.old	Sat Nov 10 20:36:44 2001
+++ kernel/ksyms.c	Sat Nov 10 20:38:04 2001
@@ -440,6 +440,7 @@
 #endif
 EXPORT_SYMBOL(kstat);
 EXPORT_SYMBOL(nr_running);
+EXPORT_SYMBOL(aligned_data);
 
 /* misc */
 EXPORT_SYMBOL(panic);


I'm running with the patch now. Seems stable (ac8 crashed pretty quickly for me).

thanks
john
