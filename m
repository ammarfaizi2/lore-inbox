Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWCLPqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWCLPqB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 10:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWCLPqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 10:46:01 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:17130 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751059AbWCLPqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 10:46:00 -0500
Date: Sun, 12 Mar 2006 16:46:02 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ericvh@gmail.com, rminnich@lanl.gov,
       lucho@ionkov.net
Subject: Re: 2.6.16-rc6-mm1
Message-ID: <20060312154602.GB16013@ens-lyon.fr>
References: <20060312031036.3a382581.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 03:10:36AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
> 
> 

fs/9p/fcprint.c:93: error: static declaration of 'v9fs_printstat' follows non-static declaration
fs/9p/9p.h:377: error: previous declaration of 'v9fs_printstat' was here
fs/9p/fcprint.c:125: error: static declaration of 'v9fs_dumpdata' follows non-static declaration
fs/9p/9p.h:376: error: previous declaration of 'v9fs_dumpdata' was here

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.fr>

Index: linux/fs/9p/9p.h
===================================================================
--- linux.orig/fs/9p/9p.h
+++ linux/fs/9p/9p.h
@@ -373,5 +373,3 @@ int v9fs_t_write(struct v9fs_session_inf
 		 u32 count, const char __user * data,
 		 struct v9fs_fcall **rcall);
 int v9fs_printfcall(char *, int, struct v9fs_fcall *, int);
-int v9fs_dumpdata(char *, int, u8 *, int);
-int v9fs_printstat(char *, int, struct v9fs_stat *, int);

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
