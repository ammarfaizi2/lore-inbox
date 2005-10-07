Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030523AbVJGSkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbVJGSkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 14:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030547AbVJGSkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 14:40:15 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:20229 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030523AbVJGSkN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 14:40:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Iuh8gZq2EAq3nZYKg0xNZLeB6ZzilGrwPaMPmdAAd+I16FXAVYueMOSwGamFgtPTO4EGBrH0v2Aqb4Tdx1xG2CcsFb+MtixMNq4d/ysL4PHntq2+vVxmJBApLQYvEzFrHUogHciJGfo5OjSgZ+ii162fkmDy6EHf2xPwPe1Zde8=
Message-ID: <9ef20ef30510071140r6402e1e8p4b7c51955774d522@mail.gmail.com>
Date: Fri, 7 Oct 2005 15:40:12 -0300
From: Gustavo Barbieri <barbieri@gmail.com>
Reply-To: Gustavo Barbieri <barbieri@gmail.com>
To: Gustavo Barbieri <barbieri@gmail.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] vm - swap_prefetch-15
In-Reply-To: <20051007182817.GA8145@jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510070001.01418.kernel@kolivas.org>
	 <84144f020510070303u13872f33hb4a40451acea4d5a@mail.gmail.com>
	 <200510072054.11145.kernel@kolivas.org>
	 <84144f020510070431n3b18250eo9d4777844a448b8a@mail.gmail.com>
	 <9ef20ef30510070744l7ff1f1bbweb4da1ceb513f246@mail.gmail.com>
	 <20051007182817.GA8145@jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/05, Rudo Thomas <rudo@matfyz.cz> wrote:
> > Or make it a "const static" variable, so compiler will check types and
> > everything, but the symbol will not be present in the binary, causing
> > no overhead. So it could be:
> >
> > const unsigned PREFETCH_PAGES = (SWAP_CLUSTER_MAX * swap_prefetch * \
> >         (1 + 9 * laptop_mode));
>
> This won't work, AFAICT. swap_prefetch and laptop_mode are variables,
> but with the code above, they would be evaluated only once. And maybe
> the compiler will reject that code immediately...

Ah... yes, you're right! These may change in runtime.

--
Gustavo Sverzut Barbieri
---------------------------------------
Computer Engineer 2001 - UNICAMP
GPSL - Grupo Pro Software Livre
Cell..: +55 (19) 9165 8010
Jabber: gsbarbieri@jabber.org
  ICQ#: 17249123
   MSN: barbieri@gmail.com
 Skype: gsbarbieri
   GPG: 0xB640E1A2 @ wwwkeys.pgp.net
