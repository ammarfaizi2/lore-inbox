Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269296AbUI3O0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbUI3O0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269300AbUI3O0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:26:07 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:42842 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S269299AbUI3OZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:25:54 -0400
Date: Thu, 30 Sep 2004 15:25:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andries.Brouwer@cwi.nl
cc: akpm@osdl.org, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overcommit symbolic constants
In-Reply-To: <UTC200409301341.i8UDfRi02421.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0409301515090.16655-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2004 Andries.Brouwer@cwi.nl wrote:
> Played a bit with overcommit the past hour.
> Am not entirely satisfied with the no overcommit mode 2 -
> programs segfault when the system is close to that boundary.
> So, instead of the somewhat larger patch that I planned to send,
> just symbolic names for the modes.

Big improvement.  And thank you for stamping on that irritating
oxymoronic "strict overcommit".  Could we add this patch in too?

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.9-rc3/Documentation/sysctl/vm.txt	2004-08-14 06:39:04.000000000 +0100
+++ linux/Documentation/sysctl/vm.txt	2004-09-30 15:23:22.340731368 +0100
@@ -47,7 +47,7 @@ of free memory left when userspace reque
 When this flag is 1, the kernel pretends there is always enough
 memory until it actually runs out.
 
-When this flag is 2, the kernel uses a "strict overcommit" 
+When this flag is 2, the kernel uses a "never overcommit" 
 policy that attempts to prevent any overcommit of memory.  
 
 This feature can be very useful because there are a lot of

