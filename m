Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUCPUZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUCPUZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:25:41 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:39177 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261635AbUCPUZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:25:39 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1
Date: Tue, 16 Mar 2004 21:24:19 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040316015338.39e2c48e.akpm@osdl.org>
In-Reply-To: <20040316015338.39e2c48e.akpm@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403162124.19075@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zJ2VAUkxC7JaNKA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_zJ2VAUkxC7JaNKA
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 16 March 2004 10:53, Andrew Morton wrote:

Hi Andrew,


> move-job-control-stuff-tosignal_struct.patch
>   moef job control fields from task_struct to signal_struct
>
> move-job-control-stuff-tosignal_struct-s390-fix.patch
>   s390 fix for move-job-control-stuff-tosignal_struct.patch
>
> move-job-control-stuff-tosignal_struct-sx-fix.patch
>
> move-job-control-stuff-tosignal_struct-sn-fix.patch
>   From: John Hawkes <hawkes@babylon.engr.sgi.com>
>   Subject: [PATCH] 2.6.4-mm1 for ia64

Please add attached patch to next -mm.


move-job-control-stuff-tosignal_struct-sparc64-fix.patch
  From: Marc-Christian Petersen <m.c.p@wolk-project.de>

;-)

ciao, Marc

--Boundary-00=_zJ2VAUkxC7JaNKA
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="move-job-control-stuff-tosignal_struct-sparc64-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="move-job-control-stuff-tosignal_struct-sparc64-fix.patch"

--- old/arch/sparc64/solaris/misc.c	2003-12-18 03:59:42.000000000 +0100
+++ new/arch/sparc64/solaris/misc.c	2004-03-16 21:20:56.000000000 +0100
@@ -402,7 +402,7 @@ asmlinkage int solaris_procids(int cmd, 
 			   Solaris setpgrp and setsid? */
 			ret = sys_setpgid(0, 0);
 			if (ret) return ret;
-			current->tty = NULL;
+			current->signal->tty = NULL;
 			return process_group(current);
 		}
 	case 2: /* getsid */

--Boundary-00=_zJ2VAUkxC7JaNKA--
