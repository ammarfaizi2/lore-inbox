Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267002AbUBGR2u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 12:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267004AbUBGR2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 12:28:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:55010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267002AbUBGR2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 12:28:12 -0500
Date: Sat, 7 Feb 2004 09:30:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: john cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA64 (2.6.2 - 2004-02-06.17.30) - 1 New warnings (gcc 3.3.1)
Message-Id: <20040207093023.1a179047.akpm@osdl.org>
In-Reply-To: <200402071643.i17Gh5v04277@build-000.pdx.osdl.net>
References: <200402071643.i17Gh5v04277@build-000.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john cherry <cherry@osdl.org> wrote:
>
>  sound/pci/vx222/vx222_ops.c:409: warning: int format, different type arg (arg 6)

--- 25/sound/pci/vx222/vx222_ops.c~vx222-warning-fix	2004-02-07 09:28:36.000000000 -0800
+++ 25-akpm/sound/pci/vx222/vx222_ops.c	2004-02-07 09:28:45.000000000 -0800
@@ -406,7 +406,8 @@ static int vx2_load_dsp(vx_core_t *vx, c
 	int err;
 
 	if (*dsp->name)
-		snd_printdd("loading dsp [%d] %s, size = %d\n", dsp->index, dsp->name, dsp->length);
+		snd_printdd("loading dsp [%d] %s, size = %Zd\n",
+			dsp->index, dsp->name, dsp->length);
 	switch (dsp->index) {
 	case 0:
 		/* xilinx image */

_

