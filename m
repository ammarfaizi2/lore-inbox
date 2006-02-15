Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030602AbWBOCrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030602AbWBOCrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbWBOCrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:47:20 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:24001 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030602AbWBOCrT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:47:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qvkms2U1YOVlAouNYIMRx570/iUqyQOwJIH+5m3XVXxyzDt9BAJjTEe5WBNTPxBECJ1XlsD80HW05zARl1xvocdjFoPKzWi14Nvwru5rN23H5ZM5OR4T5HbLZjjJq7n4RqqmsdVxFNjSmRprZhOyrhLVSf7BGa3SA6jmrRnfSkc=
Message-ID: <2cd57c900602141847m7af4ec7ap@mail.gmail.com>
Date: Wed, 15 Feb 2006 10:47:17 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + vmscan-rename-functions.patch added to -mm tree
Cc: akpm@osdl.org, christoph@lameter.com, nickpiggin@yahoo.com.au
In-Reply-To: <200602120605.k1C65QFE028051@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602120605.k1C65QFE028051@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/2/12, akpm@osdl.org <akpm@osdl.org>:
>
> The patch titled
>
>      vmscan: rename functions
>
> has been added to the -mm tree.  Its filename is
>
>      vmscan-rename-functions.patch
>
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
>
>
> From: Andrew Morton <akpm@osdl.org>
>
> We have:
>
>         try_to_free_pages
>         ->shrink_caches(struct zone **zones, ..)
>           ->shrink_zone(struct zone *, ...)
>             ->shrink_cache(struct zone *, ...)
>               ->shrink_list(struct list_head *, ...)
>
> which is fairly irrational.
>
> Rename things so that we have
>
>         try_to_free_pages
>         ->shrink_zones(struct zone **zones, ..)
>           ->shrink_zone(struct zone *, ...)
>             ->do_shrink_zone(struct zone *, ...)
>               ->shrink_page_list(struct list_head *, ...)

Every time I read this part it annoys me. Thanks.
--
Coywolf Qi Hunt
