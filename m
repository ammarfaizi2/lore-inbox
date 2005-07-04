Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVGDPQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVGDPQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 11:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVGDPQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 11:16:50 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:969 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261214AbVGDPQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 11:16:35 -0400
Date: Mon, 4 Jul 2005 17:16:32 +0200
From: David Weinehall <tao@acc.umu.se>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
       zippel@linux-m68k.org
Subject: Re: [PATCH]Fix menuconfig error message
Message-ID: <20050704151632.GF16867@khan.acc.umu.se>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net, zippel@linux-m68k.org
References: <20050704135700.GB32056@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704135700.GB32056@kurtwerks.com>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 09:57:00AM -0400, Kurt Wall wrote:
> If you try to run `make menuconfig' on a system that lacks ncurses
> development libs, you get an error message telling you to install
> ncurses-devel. Some popular distributions don't have an ncurses-devel
> package. This patch generalizes the error message. Patch is against
> 2.6.12.
> 
> MAINTAINERS doesn't list a maintainer for menuconfig or lxdialog,
> so I sent this to lkml, kbuild-devel, and to the kconfig maintainer.
> 
> Signed-off-by: Kurt Wall <kwall@kurtwerks.com>
> 
> 
> --- a/scripts/lxdialog/Makefile	2005-07-04 09:31:38.000000000 -0400
> +++ b/scripts/lxdialog/Makefile	2005-07-04 09:38:05.000000000 -0400
> @@ -35,8 +35,10 @@
>  		echo -e "\007" ;\
>  		echo ">> Unable to find the Ncurses libraries." ;\
>  		echo ">>" ;\
> -		echo ">> You must install ncurses-devel in order" ;\
> -		echo ">> to use 'make menuconfig'" ;\
> +		echo ">> You must install ncurses development libraries" ;\
> +		echo ">> to use 'make menuconfig'. If you have an RPM-based" ;\
> +		echo ">> Debian-based distribution you should install the" ;\ 
> +		echo ">> ncurses-devel package." ;\
>  		echo ;\
>  		exit 1 ;\
>  	fi

You know, I'd say that *very* few (approximately zero)
Debian-based distributions are RPM-based =)  The Debian package is
called libncurses5-dev, btw.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
