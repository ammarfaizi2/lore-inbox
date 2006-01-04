Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWADXYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWADXYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWADXYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:24:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23564 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751837AbWADXYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:24:43 -0500
Date: Thu, 5 Jan 2006 00:24:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       "Bryan O'Sullivan" <bos@pathscale.com>
Subject: [2.6 patch] Define BITS_PER_BYTE
Message-ID: <20060104232442.GX3831@stusta.de>
References: <20051108185349.6e86cec3.akpm@osdl.org> <437226B1.4040901@cosmosbay.com> <20051109220742.067c5f3a.akpm@osdl.org> <4373698F.9010608@cosmosbay.com> <43BB1178.7020409@cosmosbay.com> <20060104034534.45d9c18a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104034534.45d9c18a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 03:45:34AM -0800, Andrew Morton wrote:
>...
> +/*
> + * More than this number of fds: we use a separately allocated fd_set
> + */
> +#define EMBEDDED_FD_SET_SIZE	(8 * sizeof(struct embedded_fd_set))
> +
>...

What about applying and using the patch below?

cu
Adrian


<--  snip  -->


This can make some arithmetic expressions clearer.


Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- a/include/linux/types.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/linux/types.h	Wed Dec 28 14:19:42 2005 -0800
@@ -8,6 +8,8 @@
 	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
+
+#define BITS_PER_BYTE 8
 #endif
 
 #include <linux/posix_types.h>
