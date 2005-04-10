Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVDJXy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVDJXy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVDJXy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:54:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:19151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261490AbVDJXyW (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:54:22 -0400
Date: Sun, 10 Apr 2005 16:54:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Derek Cheung" <derek.cheung@sympatico.ca>
Cc: rddunlap@osdl.org, greg@kroah.com, Linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Message-Id: <20050410165412.707aca02.akpm@osdl.org>
In-Reply-To: <000801c53ded$04428920$1501a8c0@Mainframe>
References: <42535AF1.5080008@osdl.org>
	<000801c53ded$04428920$1501a8c0@Mainframe>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Derek Cheung" <derek.cheung@sympatico.ca> wrote:
>
> Enclosed please find the updated patch that incorporates changes for all
>  the comments I received.
> 
>  The volatile declaration in the m528xsim.h is needed because the
>  declaration refers to the ColdFire 5282 register mapping. The volatile
>  declaration is actually not needed in my I2C driver but someone may
>  include the m528xsim.h file in his/her applications and we need to force
>  the compiler not to do any optimization on the register mapping.

- Please reissue the changelog each time you reissue a patch.

- This patch adds tons of trailing whitespace.

- It breaks the x86 build.  I did this:

--- 25/drivers/i2c/busses/Kconfig~i2c-adaptor-for-coldfire-5282-cpu-fix	2005-04-10 16:52:08.000000000 -0700
+++ 25-akpm/drivers/i2c/busses/Kconfig	2005-04-10 16:52:18.000000000 -0700
@@ -31,7 +31,7 @@ config I2C_ALI1563
 
 config I2C_MCF5282LITE
         tristate "MCF5282Lite"
-        depends on I2C && EXPERIMENTAL
+        depends on I2C && EXPERIMENTAL && PPC
         help
           If you say yes to this option, support will be included for the
           I2C on the ColdFire MCF5282Lite Development Board
_


