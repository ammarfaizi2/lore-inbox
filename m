Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVAGJOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVAGJOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 04:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVAGJOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 04:14:31 -0500
Received: from smtp.seznam.cz ([212.80.76.43]:53166 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S261326AbVAGJMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 04:12:20 -0500
Date: Fri, 7 Jan 2005 10:12:19 +0100
To: Greg KH <greg@kroah.com>
Cc: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>,
       Ralf Baechle <ralf@linux-mips.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com, linux-mips@linux-mips.org
Subject: Re: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-ID: <20050107091218.GA3715@orphique>
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de> <20050106192701.GA13955@linux-mips.org> <41DD9313.4030105@total-knowledge.com> <20050106194646.GB5481@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106194646.GB5481@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 11:46:46AM -0800, Greg KH wrote:
> Ok, can someone send me the proper patch then?

Index: drivers/i2c/algos/Kconfig
===================================================================
RCS file: /home/cvs/linux/drivers/i2c/algos/Kconfig,v
retrieving revision 1.3
diff -u -r1.3 Kconfig
--- drivers/i2c/algos/Kconfig	24 Aug 2004 15:10:09 -0000	1.3
+++ drivers/i2c/algos/Kconfig	7 Jan 2005 09:10:10 -0000
@@ -61,7 +61,7 @@
 
 config I2C_ALGO_SGI
 	tristate "I2C SGI interfaces"
-	depends on I2C
+	depends on I2C && (SGI_IP22 || SGI_IP32 || X86_VISWS)
 	help
 	  Supports the SGI interfaces like the ones found on SGI Indy VINO
 	  or SGI O2 MACE.
