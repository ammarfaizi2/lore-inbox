Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbVHXF2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbVHXF2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 01:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVHXF2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 01:28:13 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:52920 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751462AbVHXF2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 01:28:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=dgVpypjHcWvSFj75LWFs408BJu+D1Yi8nnqi+/rDzDpDeYB7YgXCHCVvHz3P7Q7+amQsjqSq2RbOO7UrgtG0DsbVI902G4c3M++xuvpecsQrqUYBN08grJZrHc02zjlUUjSsOs53XMDx6H9g4uu0YmLNd05MgSYdeQkHAEGMXYw=
Date: Wed, 24 Aug 2005 09:37:04 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Nick Sillik <n.sillik@temple.edu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [-mm PATCH] drivers/char/speakup/synthlist.h - Fix warnings with -Wundef
Message-ID: <20050824053703.GA23807@mipter.zuzino.mipt.ru>
References: <430B8063.8070301@temple.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430B8063.8070301@temple.edu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 04:00:35PM -0400, Nick Sillik wrote:
> This patch fixes (it should) the following warnings generated with -Wundef 
> in the file drivers/char/speakup/synthlist.h
> 
> drivers/char/speakup/synthlist.h:13:35: warning: "CONFIG_SPEAKUP_ACNTPC" is 
> not defined

> --- linux-2.6.13-rc6-mm2/drivers/char/speakup/synthlist.h
> +++ linux-2.6.13-rc6-mm2-patched/drivers/char/speakup/synthlist.h

> -#define  CFG_TEST(name) (name)
> +#define  CFG_TEST(name) defined(name)

No. Just remove this obfuscating macro.

>  #endif
>  
>  #if CFG_TEST(CONFIG_SPEAKUP_ACNTPC)
   ^^^^^^^^^^^^

Yuck.

