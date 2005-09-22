Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVIVGsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVIVGsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVIVGsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:48:38 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:28105 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932138AbVIVGsi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:48:38 -0400
X-ME-UUID: 20050922064836660.A13BA1C001E3@mwinf0812.wanadoo.fr
In-Reply-To: <20050921172550.GA10332@nevyn.them.org>
References: <20050921172550.GA10332@nevyn.them.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <4D3DE86B-EDE9-494E-A935-A6CE9CFF1134@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Content-Transfer-Encoding: 8BIT
From: Laurent Vivier <LaurentVivier@wanadoo.fr>
Subject: Re: PTRACE_SYSEMU numbering
Date: Thu, 22 Sep 2005 08:48:35 +0200
To: Daniel Jacobowitz <dan@debian.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there is no problem for me.
Paolo, as you are the submitter of the patch to the list and the real  
maintainer, what do you think about that ?

Regards,
Laurent

Le 21 sept. 05 à 19:25, Daniel Jacobowitz a écrit :

> Here's a bit of the PTRACE_SYSEMU patch, committed three weeks ago:
>
> --- a/include/linux/ptrace.h
> +++ b/include/linux/ptrace.h
> @@ -20,6 +20,7 @@
>  #define PTRACE_DETACH 0x11
>  #define PTRACE_SYSCALL 24
> +#define PTRACE_SYSEMU 31
>
>  /* 0x4200-0x4300 are reserved for architecture-independent  
> additions. */
>  #define PTRACE_SETOPTIONS 0x4200
>
> OK, I admit I could have made the comment clearer.  But can we fix  
> this?
> You've added PTRACE_SYSEMU on top of PTRACE_GETFDPIC, which  
> presumably will
> mess up either debugging or UML on that architecture (if the latter  
> were
> ported).  That's exactly the problem we defined the 0x4200-0x4300  
> range
> to prevent.
>
> -- 
> Daniel Jacobowitz
> CodeSourcery, LLC
>

Laurent Vivier
LaurentVivier@wanadoo.fr



