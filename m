Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVI3Cn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVI3Cn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVI3Cn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:43:59 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:9264 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932200AbVI3Cn6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:43:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q/3Cyy/AT9oT7UQL9oNqiH7Ewug08PnVSwqwRG/4+Ja/GMWPqQhiGcrHlrEgT3koRThfNic1640J7fTgFL5WTaJrYoYfLKOFCpoET2spd3rrzz4HumKz6NQOjDbBW2+QbG1xPMuRTAkA+4hDHuZsvEiB7KaFAlPSS8i2Va5mJ54=
Message-ID: <5bdc1c8b0509291943j10d382f4y36178f4c171f878c@mail.gmail.com>
Date: Thu, 29 Sep 2005 19:43:57 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: dwalker@mvista.com
Subject: Re: l2.6.14-rc2-rt7 - build problems - mce?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0509291936u2d2036e6ic91f68f33db5342d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0509291907x77604133oc1d8a64e9e70dd59@mail.gmail.com>
	 <1128046979.987.36.camel@dhcp153.mvista.com>
	 <5bdc1c8b0509291936u2d2036e6ic91f68f33db5342d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/05, Mark Knecht <markknecht@gmail.com> wrote:
> On 9/29/05, Daniel Walker <dwalker@mvista.com> wrote:
> > I think it's something else completely .. You would be better off
> > turning on complete preemption .
> >
> > Daniel
>
> Thanks.
>
> make allnoconfig   builds
> make defconfig fails as per my earlier message
>
> make defconfig and then turning on complete preemption is doing this:
>
>   CC      mm/fadvise.o
>   CC      mm/page_alloc.o
>   CC      mm/page-writeback.o
>   CC      mm/pdflush.o
>   CC      mm/readahead.o
>   CC      mm/slab.o
> mm/slab.c:2404: error: conflicting types for 'kmem_cache_alloc_node'
> include/linux/slab.h:122: error: previous declaration of
> 'kmem_cache_alloc_node' was here
> mm/slab.c:2404: error: conflicting types for 'kmem_cache_alloc_node'
> include/linux/slab.h:122: error: previous declaration of
> 'kmem_cache_alloc_node' was here
> make[1]: *** [mm/slab.o] Error 1
> make: *** [mm] Error 2
> lightning linux-2.6.14-rc2-rt7 #
>
> I will continue on. Thanks very much for your help.
>
> Thanks,
> Mark
>

Great! It still failed but built after I turned NUMA off.

Thanks VERY much!!

- Mark
