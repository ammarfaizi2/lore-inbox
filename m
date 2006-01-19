Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161128AbWASBFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbWASBFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbWASBFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:05:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51209 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161128AbWASBFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:05:38 -0500
Date: Thu, 19 Jan 2006 02:05:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make pcmcia_release_{io,irq} static
Message-ID: <20060119010536.GU19398@stusta.de>
References: <20060118005053.118f1abc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118005053.118f1abc.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 12:50:53AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm4:
>...
>  git-pcmcia.patch
>...
>  git trees
>...


We can now make pcmcia_release_{io,irq} static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm1-full/drivers/pcmcia/pcmcia_resource.c.old	2006-01-18 23:15:05.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/pcmcia/pcmcia_resource.c	2006-01-18 23:15:23.000000000 +0100
@@ -511,7 +511,7 @@
  * don't bother checking the port ranges against the current socket
  * values.
  */
-int pcmcia_release_io(struct pcmcia_device *p_dev, io_req_t *req)
+static int pcmcia_release_io(struct pcmcia_device *p_dev, io_req_t *req)
 {
 	struct pcmcia_socket *s = p_dev->socket;
 	config_t *c = p_dev->function_config;
@@ -537,7 +537,7 @@
 } /* pcmcia_release_io */
 
 
-int pcmcia_release_irq(struct pcmcia_device *p_dev, irq_req_t *req)
+static int pcmcia_release_irq(struct pcmcia_device *p_dev, irq_req_t *req)
 {
 	struct pcmcia_socket *s = p_dev->socket;
 	config_t *c= p_dev->function_config;

