Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318494AbSGSKuS>; Fri, 19 Jul 2002 06:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318496AbSGSKuS>; Fri, 19 Jul 2002 06:50:18 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:64649 "EHLO gagarin")
	by vger.kernel.org with ESMTP id <S318494AbSGSKuS>;
	Fri, 19 Jul 2002 06:50:18 -0400
Date: Fri, 19 Jul 2002 12:52:44 +0200
To: Russell King <rmk@arm.linux.org.uk>
Cc: Werner Almesberger <wa@almesberger.net>, linux-kernel@vger.kernel.org,
       jsimmons@transvirtual.com
Subject: Re: [PATCH] CONFIG_MAGIC_SYSRQ without CONFIG_VT broken in 2.5.26
Message-ID: <20020719105244.GB13706@h55p111.delphi.afb.lu.se>
References: <20020718220635.A15794@almesberger.net> <20020719091017.A28569@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719091017.A28569@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 09:10:17AM +0100, Russell King wrote:


> @@ -371,7 +371,9 @@
>  		 as 'Off' at init time */
>  /* p */	&sysrq_showregs_op,
>  /* q */	NULL,
> +#ifdef CONFIG_VT
>  /* r */	&sysrq_unraw_op,
> +#endif


Shouldn't that be something more like?

+#ifdef CONFIG_VT
 /* r */      &sysrq_unraw_op,
+#else
+/* r */      NULL,
+#endif


-- 

//anders/g

