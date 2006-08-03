Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWHCUOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWHCUOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWHCUOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:14:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:7286 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932548AbWHCUOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:14:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=d8mmlOvGu3Tc+PQk+ravZwTu/uIhECLaarCotGha5q7hDpzIlRUUTyHY3dzR4lqUmOv6UBEbj9CTixo6QwmhCqDchGpdg3DqZYTGv1wwVAJLcaB6Kbku99vk+2OAVR9+iXP/G448f2GVleKrDmPBPulXS1dp97WKjF3NetEI7Zo=
Date: Fri, 4 Aug 2006 00:14:02 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Userspace visible of 3 include/asm/ headers
Message-ID: <20060803201402.GA6828@martell.zuzino.mipt.ru>
References: <20060803193952.GF25692@stusta.de> <20060803194410.GC16927@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803194410.GC16927@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 03:44:10PM -0400, Dave Jones wrote:
> On Thu, Aug 03, 2006 at 09:39:52PM +0200, Adrian Bunk wrote:
>  > Could anyone help me regarding the desired userspace visibility of the
>  > following three headers under include/asm/?
>  >
>  > Header        : cpufeature.h
>  > Architectures : i386, x86_64
>  > Is there any reason why this header is exported to userspace?
>
> Probably not. The only apps I've seen that care about feature bits
> define them theirselves rather than use these.

Feature bits are only (indirectly) visible via /proc/cpuinfo.
struct cpuinfo_x86, AFAICS, is never copied to userspace. So, it's safe
to remove this header.

