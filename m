Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTEKNId (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 09:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbTEKNIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 09:08:32 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:37327 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261437AbTEKNIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 09:08:31 -0400
Date: Sun, 11 May 2003 14:21:20 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.69-dj1: agp_init shouldn't be static
Message-ID: <20030511132120.GA8834@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Adrian Bunk <bunk@fs.tum.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030510145653.GA26216@suse.de> <20030511122934.GH1107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030511122934.GH1107@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 02:29:35PM +0200, Adrian Bunk wrote:

 > -dj makes agp_init static resulting in the following error at the final 
 > linking:
 > ...
 > 386/oprofile/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
 > drivers/built-in.o(.init.text+0x6b584): In function `i810fb_init':
 > : undefined reference to `agp_init'
 > make: *** [.tmp_vmlinux1] Error 1


duhh, the 810 framebuffer needs it early. I forgot about that.
Will apply patch, and add a comment. Thanks.

		Dave
 

