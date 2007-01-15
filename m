Return-Path: <linux-kernel-owner+w=401wt.eu-S1751433AbXAOWLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXAOWLr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 17:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAOWLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 17:11:47 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:45721 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbXAOWLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 17:11:46 -0500
Date: Mon, 15 Jan 2007 23:11:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rob Landley <rob@landley.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sed s/gawk/awk/ scripts/gen_init_ramfs.sh
Message-ID: <20070115221146.GA12698@uranus.ravnborg.org>
References: <200701151624.18033.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200701151624.18033.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 04:24:17PM -0500, Rob Landley wrote:
> Signed-off-by: Rob Landley <rob@landley.net>
Acked-by: Sam Ravnborg <sam@ravnborg>

PS
My dev machine is broke and need a new one before kbuild.git will
be alive again.
Considering an AMD Athlon 64 X2 based one with Nvidia GeForce™ 6150LE:
http://h10010.www1.hp.com/wwpc/dk/da/ho/WF06b/34307-351123-1284187-1284187-1284187-12726540-78048221.html
Anyone with comments on this choice?

	Sam
> 
> Use "awk" instead of "gawk".
> 
> -- 
> 
> There's a symlink from awk to gawk if you're using the gnu tools, but no
> symlink from gawk to awk if you're using BusyBox or some such.  (There's a
> reason for the existence of standard names.  Can we use them please?)
> 
> --- linux-2.6.19.2/scripts/gen_initramfs_list.sh	2007-01-10 14:10:37.000000000 -0500
> +++ linux-new/scripts/gen_initramfs_list.sh	2007-01-15 10:14:41.000000000 -0500
> @@ -121,9 +121,9 @@
>  		"nod")
>  			local dev_type=
>  			local maj=$(LC_ALL=C ls -l "${location}" | \
> -					gawk '{sub(/,/, "", $5); print $5}')
> +					awk '{sub(/,/, "", $5); print $5}')
>  			local min=$(LC_ALL=C ls -l "${location}" | \
> -					gawk '{print $6}')
> +					awk '{print $6}')
>  
>  			if [ -b "${location}" ]; then
>  				dev_type="b"
> @@ -134,7 +134,7 @@
>  			;;
>  		"slink")
>  			local target=$(LC_ALL=C ls -l "${location}" | \
> -					gawk '{print $11}')
> +					awk '{print $11}')
>  			str="${ftype} ${name} ${target} ${str}"
>  			;;
>  		*)
> 
> -- 
> "Perfection is reached, not when there is no longer anything to add, but
> when there is no longer anything to take away." - Antoine de Saint-Exupery
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
