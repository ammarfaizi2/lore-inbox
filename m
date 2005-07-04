Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVGDSdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVGDSdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 14:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVGDSdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 14:33:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:1432 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261430AbVGDScp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 14:32:45 -0400
Date: Mon, 4 Jul 2005 20:32:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Kurt Wall <kwall@kurtwerks.com>
cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [PATCH]Fix menuconfig error message
In-Reply-To: <20050704155350.GB2082@kurtwerks.com>
Message-ID: <Pine.LNX.4.61.0507042028200.3728@scrub.home>
References: <20050704155350.GB2082@kurtwerks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 4 Jul 2005, Kurt Wall wrote:

> --- a/scripts/lxdialog/Makefile	2005-07-04 09:54:44.000000000 -0400
> +++ b/scripts/lxdialog/Makefile	2005-07-04 11:50:00.000000000 -0400
> @@ -35,8 +35,11 @@
>  		echo -e "\007" ;\
>  		echo ">> Unable to find the Ncurses libraries." ;\
>  		echo ">>" ;\
> -		echo ">> You must install ncurses-devel in order" ;\
> -		echo ">> to use 'make menuconfig'" ;\
> +		echo ">> You must install ncurses development libraries" ;\
> +		echo ">> to use 'make menuconfig'. If you have an RPM-based" ;\
> +		echo ">> distribution you should install the ncurses-devel" ;\
> +		echo ">> Debian users will probably want to install the
> +		echo ">> libncurses5-dev package." ;\
>  		echo ;\
>  		exit 1 ;\
>  	fi

I would prefer if we don't mention special distributions or version 
numbers and just mentioned a few common package names.
On Debian libncurses-dev or ncurses-dev works as well and so is better 
than libncurses5-dev.

bye, Roman
