Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWEARGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWEARGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWEARGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:06:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27302 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932158AbWEARGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:06:02 -0400
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
From: David Woodhouse <dwmw2@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <20060430174426.a21b4614.rdunlap@xenotime.net>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Mon, 01 May 2006 18:06:06 +0100
Message-Id: <1146503166.2885.137.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 17:44 -0700, Randy.Dunlap wrote:
> + (b) Clear integer types, where the abstraction _helps_ avoid confusion
> +     whether it is "int" or "long".
> +
> +     u8/u16/u32 are perfectly fine typedefs. 

No, u8/u16/u32 are fall into category (d):

 (d) New types which are identical to standard C99 types, in certain
     exceptional circumstances.

     Although it would only take a short amount of time for the eyes and
     brain to become accustomed to the standard types like 'uint32_t',
     some people object to their use anyway.

     Therefore, the gratuitous 'u8/u16/u32/u64' types and their signed
     equivalents which are identical to standard types are permitted --
     although they are not mandatory.

 (e) Types safe for use in userspace. 

     In certain structures which are visible to userspace, we cannot
     require C99 types and cannot use the 'u32' form above. Thus, we
     use __u32 and similar types in all structures which are shared
     with userspace.

-- 
dwmw2

