Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVBADaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVBADaR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 22:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVBADaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 22:30:17 -0500
Received: from [195.23.16.24] ([195.23.16.24]:20875 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261518AbVBADaL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 22:30:11 -0500
Message-ID: <1107228497.41fef75134306@webmail.grupopie.com>
Date: Tue,  1 Feb 2005 03:28:17 +0000
From: "" <pmarques@grupopie.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] 0/7 make kstrdup a library function
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.143.60
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This series of patches create a "char *kstrdup(const char *s, int gfp)" library
function, and remove all the "private" strdup implementations in the kernel
tree.

1 - create a kstrdup library function
2 - remove private strdup from drivers/md/dm-ioctl.c
3 - remove private strdup from drivers/parport/probe.c
4 - remove uml_strdup (UML architecture)
5 - remove private strdup from net/sunrpc/svcauth_unix.c
6 - remove net_sysctl_strdup (networking)
7 - remove snd_kmalloc_strdup (sound)

This is just a cleanup to allow reusing the strdup code, and to prevent bugs in
future duplications of strdup.

These patches were built against 2.6.11-rc2-bk9. Patch 1/7 is similar to a patch
sent by Rusty Russell (although not quite the same), and 2/7 is also similar to
another patch sent today by Matt Domsch. So these should go over a vanilla
kernel without any of those patches.

All the patches depend on the first patch, but are otherwise independent.

Signed-off-by: Paulo Marques <pmarques@grupopie.com>

--
Paulo Marques - www.grupopie.com
 
All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
