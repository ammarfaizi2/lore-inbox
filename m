Return-Path: <linux-kernel-owner+w=401wt.eu-S932808AbWL0NEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbWL0NEK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 08:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbWL0NEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 08:04:09 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42548 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791AbWL0NEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 08:04:08 -0500
Message-Id: <200612271303.kBRD3tSJ007866@laptop13.inf.utfsm.cl>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove logically superfluous comparisons from Kconfig files. 
In-Reply-To: Message from "Robert P. J. Day" <rpjday@mindspring.com> 
   of "Mon, 18 Dec 2006 05:14:01 CDT." <Pine.LNX.4.64.0612180509010.22527@localhost.localdomain> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Wed, 27 Dec 2006 10:03:55 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 27 Dec 2006 10:03:56 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day <rpjday@mindspring.com> wrote:
>   Remove Kconfig comparisons of the form FUBAR || FUBAR=n, since they
> appear to be superfluous.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   based on what i read in kconfig-language.txt, it would *appear* that
> those comparisons are redundant, but i'm willing to be convinced
> otherwise.  (unless the developer specifically wanted the case of
> "!=m", which i'm fairly sure is not the same thing, yes?)

Would be clearer written that way if so.

>  drivers/char/drm/Kconfig   |    2 +-
>  fs/dlm/Kconfig             |    1 -
>  net/ipv4/netfilter/Kconfig |    1 -
>  net/sctp/Kconfig           |    1 -
>  4 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
> index ef833a1..d681e68 100644
> --- a/drivers/char/drm/Kconfig
> +++ b/drivers/char/drm/Kconfig
> @@ -6,7 +6,7 @@
>  #
>  config DRM
>  	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
> -	depends on (AGP || AGP=n) && PCI
> +	depends on && PCI
                   ^^ ???

>  	help
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
