Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTK1LYE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 06:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTK1LYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 06:24:04 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:47526 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262164AbTK1LYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 06:24:02 -0500
Date: Fri, 28 Nov 2003 12:22:51 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: felipe_alfaro@linuxmail.org, rmk+lkml@arm.linux.org.uk, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
Message-ID: <20031128112251.GA18276@wohnheim.fh-wedel.de>
References: <1069974209.5349.7.camel@teapot.felipe-alfaro.com> <20031128.092326.39861126.yoshfuji@linux-ipv6.org> <20031128.092642.47232575.yoshfuji@linux-ipv6.org> <20031128.094022.106776635.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031128.094022.106776635.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 November 2003 09:40:22 +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> In article <20031128.092642.47232575.yoshfuji@linux-ipv6.org> (at Fri, 28 Nov 2003 09:26:42 +0900 (JST)), YOSHIFUJI Hideaki / ?$B5HF#1QL@ <yoshfuji@linux-ipv6.org> says:
> 
> > >  3)   if (len)
> > >          strncpy(dst, src, len - 1);
> > >       dst[len] = 0;
> 
> grr, another mistake...:
> 
>           if (len) {
>              strncpy(dst, src, len - 1);
>              dst[len - 1];
                           ^
>           }

Did you forget ' = 0' there? ;)

Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c
