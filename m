Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUF3W7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUF3W7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 18:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUF3W7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 18:59:14 -0400
Received: from postman1.arcor-online.net ([151.189.20.156]:8599 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261682AbUF3W7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 18:59:12 -0400
Message-ID: <40E345BC.2070008@flashmail.com>
Date: Thu, 01 Jul 2004 00:59:08 +0200
From: Frieder Buerzele <stamm@flashmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-np2
References: <40E00EA4.8060205@yahoo.com.au>
In-Reply-To: <40E00EA4.8060205@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

must I still renice X to get your patch run without responsive-lose 
during I/O e.g with cdparanoia?
thx

I had to edit fs/hfsplus/inode.c to get it compile properly

--- fs/hfsplus/inode.c.orig     2004-07-01 00:51:52.347198744 +0200
+++ fs/hfsplus/inode.c  2004-07-01 00:42:00.685145048 +0200
@@ -72,7 +72,7 @@
                                res = 0;
                        else for (i = 0; i < tree->pages_per_bnode; i++) {
                                if (PageActiveMapped(node->page[i]) ||
-                                       
PageActiveUnmapped(node->page[i]))) {
+                                       PageActiveUnmapped(node->page[i])) {
                                        res = 0;
                                        break;


Nick Piggin wrote:

> http://www.kerneltrap.org/~npiggin/2.6.7-np2.gz
>
> This is against 2.6.7-mm3. I can do one against -bk if anyone would
> like.
>
> It should fix scheduler problems and compile problems in 2.6.7-np1.
>
> It contains my CPU scheduler and memory management stuff. If anyone
> is having swapping or interactivity problems, please try it out.

