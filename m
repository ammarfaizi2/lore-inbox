Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWBBRIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWBBRIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWBBRIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:08:04 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:52313 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932175AbWBBRID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:08:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=kYpAT7S+NuP0/biYBZy2NXuaFmCDqnYRc2IDxxWJCIfS1HgyiWYMobkaXZtElGae/Kyxw62nZ8L1Ss8cxDhQq1n6WTKvq3KyOD4sWGQZr9UT5dKj4JjDZlanznkuEpljhOrHaQZW1TTc9O9uFRdOYQJ5ll6gs6ichvEyGED2fr4=
Date: Thu, 2 Feb 2006 20:26:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xquad_portio fix declaration missmatch
Message-ID: <20060202172609.GA4231@mipter.zuzino.mipt.ru>
References: <20060202004306.GA32466@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202004306.GA32466@shadowen.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 12:43:06AM +0000, Andy Whitcroft wrote:
> xquad_portio fix declaration missmatch

>   arch/i386/boot/compressed/misc.c:125: error: static declaration of
> 				'xquad_portio' follows non-static declaration
>   include/asm/io.h:315: error: previous declaration of 'xquad_portio' was here

> --- reference/arch/i386/boot/compressed/misc.c
> +++ current/arch/i386/boot/compressed/misc.c
> @@ -122,7 +122,7 @@ static int vidport;
>  static int lines, cols;
>  
>  #ifdef CONFIG_X86_NUMAQ
> -static void * xquad_portio = NULL;
> +void * xquad_portio = NULL;
>  #endif

Can you explain why it should stay in misc.c?

