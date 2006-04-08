Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWDHUOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWDHUOV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWDHUOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:14:21 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32526 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751423AbWDHUOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:14:19 -0400
Date: Sat, 8 Apr 2006 22:14:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, hpa@zytor.com, mm-commits@vger.kernel.org
Subject: Re: + git-klibc-mktemp-fix.patch added to -mm tree
Message-ID: <20060408201412.GA26946@mars.ravnborg.org>
References: <200604080707.k38778VV023208@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604080707.k38778VV023208@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2006 at 12:05:54AM -0700, akpm@osdl.org wrote:
> diff -puN usr/dash/mkbuiltins~git-klibc-mktemp-fix usr/dash/mkbuiltins
> --- 25/usr/dash/mkbuiltins~git-klibc-mktemp-fix	Sat Apr  8 14:51:11 2006
> +++ 25-akpm/usr/dash/mkbuiltins	Sat Apr  8 14:51:11 2006
> @@ -37,7 +37,7 @@
>  
>  tempfile=tempfile
>  if ! type tempfile > /dev/null 2>&1; then
> -	tempfile=mktemp
> +	tempfile="mktemp /tmp/tmp.XXXXXX"

Shouldn't that be:
> +	tempfile="$(mktemp /tmp/tmp.XXXXXX)"

	Sam
