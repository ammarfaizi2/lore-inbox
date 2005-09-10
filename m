Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbVIJGdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbVIJGdY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 02:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbVIJGdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 02:33:24 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:58283 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932650AbVIJGdX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 02:33:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F5PNgYRUPNK989D1y3KI3o1OxT9FPrvJFB7pPOXHaXzQBNTYY6JRgRdC0TMQCoTK6eFCjmVOxmHBY6p20IYEsEN/7Mx9//PLqblo0/NILg+l37wFeXcyADfgJH2vbsJ7YeEgDN3tQmbRy7Jsy/T9jJ3qgnvi+06DzbkuLWqis8s=
Message-ID: <9cfa10eb05090923333e111457@mail.gmail.com>
Date: Sat, 10 Sep 2005 09:33:20 +0300
From: Marko Kohtala <marko.kohtala@gmail.com>
Reply-To: marko.kohtala@gmail.com
To: Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: 2.6.13-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <d243i19hk055rl5b5o5i9suofsvbmv5r8l@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050908053042.6e05882f.akpm@osdl.org>
	 <m1q1i1lav2vl7k0lpposq0uj4uobsptnor@4ax.com>
	 <20050909024336.01763521.akpm@osdl.org>
	 <d243i19hk055rl5b5o5i9suofsvbmv5r8l@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> Hi Andrew, Marko,
> On Fri, 9 Sep 2005 02:43:36 -0700, Andrew Morton <akpm@osdl.org> wrote:
> >Grant Coady <grant_lkml@dodo.com.au> wrote:
> >> On Thu, 8 Sep 2005 05:30:42 -0700, Andrew Morton <akpm@osdl.org> wrote:
> >>
> >> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> >>
> >> Hi Andrew,
> >>
> >> After this error:
> >>
> >>   CC      drivers/parport/parport_pc.o
> >> drivers/parport/parport_pc.c:2511: error: via_686a_data causes a section type conflict
> >> drivers/parport/parport_pc.c:2520: error: via_8231_data causes a section type conflict
> >> drivers/parport/parport_pc.c:2705: error: parport_pc_superio_info causes a section type conflict
> >> drivers/parport/parport_pc.c:2782: error: cards causes a section type conflict
> >> make[2]: *** [drivers/parport/parport_pc.o] Error 1
> >> make[1]: *** [drivers/parport] Error 2
> >> make: *** [drivers] Error 2
> >
> >Yes, gcc 4.x doesn't like the consts for some reason.

And this was documented in linux/init.h: __devinitdata can not be
const. My mistake. Thanks for fixing it.
