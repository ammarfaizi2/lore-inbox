Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVK3LAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVK3LAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 06:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVK3LAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 06:00:40 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:4420 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751065AbVK3LAj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 06:00:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cu/ogCPn50teGUEC+RDOHhDu5qxcOWF9P411YFRH/QKauUoGXkfgSaeuBeNReglKZo909corn33E8uUaOtkIXFBsh3ECh3U3Ma7cKNPbnWINbIvheHUXxJSi1+JnwQsB+lIHuuzxgTAHYo8lAucCkcKnkEP0/VRmAoN6n/0E4Ps=
Message-ID: <58cb370e0511300300x2aa34159mfb46e9e49d10ec0f@mail.gmail.com>
Date: Wed, 30 Nov 2005 12:00:37 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 08/11] blk: update IDE to use new blk_ordered
Cc: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051124162449.DB507E8E@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051124162449.209CADD5@htj.dyndns.org>
	 <20051124162449.DB507E8E@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/05, Tejun Heo <htejun@gmail.com> wrote:
> 08_blk_ide-update-ordered.patch
>
>         Update IDE to use new blk_ordered.  This change makes the
>         following behavior changes.
>
>         * Partial completion of the barrier request is handled as
>           failure of the whole ordered sequence.  No more partial
>           completion for barrier requests.
>
>         * Any failure of pre or post flush request results in failure
>           of the whole ordered sequence.
>
>         So, successfully completed ordered sequence guarantees that
>         all requests prior to the barrier made to physical medium and,
>         then, the while barrier request made to the physical medium.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, looks fine
