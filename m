Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161277AbWASQaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161277AbWASQaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161278AbWASQaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:30:11 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:31504 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161277AbWASQaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:30:09 -0500
Date: Thu, 19 Jan 2006 17:29:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Aneesh Kumar <aneesh.kumar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Add entry.S labels to tag file.
Message-ID: <20060119162958.GA12486@mars.ravnborg.org>
References: <cc723f590601190329h5239c4dfnff23c07a5bbc384e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc723f590601190329h5239c4dfnff23c07a5bbc384e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 04:59:05PM +0530, Aneesh Kumar wrote:
> The below patch add functions defined using ENTRY macro to the tag
> file generated
> using ctags.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

> diff --git a/Makefile b/Makefile
> index 252a659..8f0cc11 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1272,7 +1272,7 @@ define cmd_tags
>  	CTAGSF=`ctags --version | grep -i exuberant >/dev/null &&     \
>                  echo "-I __initdata,__exitdata,__acquires,__releases  \
>                        -I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL              \
> -                      --extra=+f --c-kinds=+px"`;                     \
> +                      --extra=+f --c-kinds=+px --regex-asm=/ENTRY\(([^)]*)\).*/\1/"`;  \
>                  $(all-sources) | xargs ctags $$CTAGSF -a
>  endef

Fixed line length and applied.
Was this not relevant for etags?

	Sam
