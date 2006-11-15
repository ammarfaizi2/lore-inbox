Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030765AbWKORvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030765AbWKORvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030767AbWKORvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:51:07 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:31396 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1030765AbWKORvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:51:05 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] Fix strange size check in __get_vm_area_node()
Date: Wed, 15 Nov 2006 18:51:09 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <87k61wa9to.fsf@duaron.myhome.or.jp>
In-Reply-To: <87k61wa9to.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151851.09649.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 18:39, OGAWA Hirofumi wrote:
> Recently, __get_vm_area_node() was changed like following
>
>  	if (unlikely(!area))
>  		return NULL;
>
> -	if (unlikely(!size)) {
> -		kfree (area);
> +	if (unlikely(!size))
>  		return NULL;
> -	}
>
> It is leaking `area', also original code seems strange already.
> Probably, we wanted to do this patch.
>

Indeed. I checked my original patch and it was correct. I dont know what 
happened then...

http://lkml.org/lkml/2006/10/23/86

Eric
