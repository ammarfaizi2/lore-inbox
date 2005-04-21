Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVDUCpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVDUCpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 22:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVDUCpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 22:45:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:21936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261192AbVDUCp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 22:45:26 -0400
Date: Wed, 20 Apr 2005 19:42:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux@syskonnect.de, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [2.6 patch] drivers/net/skfp/: fix LITTLE_ENDIAN
Message-Id: <20050420194200.4354510e.rddunlap@osdl.org>
In-Reply-To: <20050420021708.GD5489@stusta.de>
References: <20050420021708.GD5489@stusta.de>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2005 04:17:08 +0200 Adrian Bunk wrote:

| This patch fixes the LITTLE_ENDIAN #define.
  and a function prototype.

| Signed-off-by: Adrian Bunk <bunk@stusta.de>
| 
| ---
| 
|  drivers/net/skfp/h/osdef1st.h |    2 ++
|  drivers/net/skfp/smt.c        |    2 +-
|  2 files changed, 3 insertions(+), 1 deletion(-)
| 
| --- linux-2.6.12-rc2-mm3-full/drivers/net/skfp/h/osdef1st.h.old	2005-04-20 01:22:21.000000000 +0200
| +++ linux-2.6.12-rc2-mm3-full/drivers/net/skfp/h/osdef1st.h	2005-04-20 01:23:55.000000000 +0200
| @@ -20,6 +20,8 @@
|  // HWM (HardWare Module) Definitions
|  // -----------------------
|  
| +#include <asm/byteorder.h>
| +
|  #ifdef __LITTLE_ENDIAN
|  #define LITTLE_ENDIAN
|  #else
| --- linux-2.6.12-rc2-mm3-full/drivers/net/skfp/smt.c.old	2005-04-20 01:26:34.000000000 +0200
| +++ linux-2.6.12-rc2-mm3-full/drivers/net/skfp/smt.c	2005-04-20 01:26:22.000000000 +0200
| @@ -86,7 +86,7 @@
|  static void smt_send_sif_operation(struct s_smc *smc, struct fddi_addr *dest,
|  				   u_long tid, int local);
|  #ifdef LITTLE_ENDIAN
| -static void smt_string_swap(void);
| +static void smt_string_swap(char *data, const char *format, int len);
|  #endif
|  static void smt_add_frame_len(SMbuf *mb, int len);
|  static void smt_fill_una(struct s_smc *smc, struct smt_p_una *una);
