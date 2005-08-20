Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVHTFqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVHTFqu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 01:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVHTFqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 01:46:50 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:55700 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751084AbVHTFqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 01:46:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ASJU9D8rCqgw2iFWIp4xiN/gw4TR3sg62k5+AWodyzZAR1yORnq5uTpAjHcV4UcAM0Uk4mLWPrbIZ4J/krow5TaVFyayneKNv0pR7R1ydEOw/VMPWzPBjROmYNNW2g1ywqdh+xv2hGbnbt/h1ZX3Lc9gTRS9d1aSil7YWIzGatU=
Date: Sat, 20 Aug 2005 09:55:32 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] adapt scripts/ver_linux to new util-linux version strings
Message-ID: <20050820055532.GA15577@mipter.zuzino.mipt.ru>
References: <20050820035853.GM3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050820035853.GM3615@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 05:58:53AM +0200, Adrian Bunk wrote:
> --- linux-2.6.13-rc6-mm1-full/scripts/ver_linux.old
> +++ linux-2.6.13-rc6-mm1-full/scripts/ver_linux

> -fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
> +fdformat --version | awk '{print "util-linux            ", $NF}' \
> +| awk -F\) '{print $1}'
>  
> -mount --version | awk -F\- '{print "mount                 ", $NF}'
> +mount --version | awk '{print "mount                 ", $NF}' | \
> +awk -F\) '{print $1}'

-util-linux             2.12i
-mount                  2.12i
+util-linux             util-linux-2.12i
+mount                  mount-2.12i
			^^^^^^

Is this intentional?

