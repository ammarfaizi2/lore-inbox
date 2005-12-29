Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbVL2IGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVL2IGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbVL2IGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:06:18 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:47161 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932589AbVL2IGR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:06:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j6BBlfIuCxqAvAviryK84NpzF1y3kdxdDZw+GpA/Rj4KKsKuE7rV+eSt6lXVo6XKPv2PxWudSKIo/RUUicg7pmTweIbAIusjQsyeFdx5dqDk8d6c+ZjHo3eRAebntHe61KqJeEG3YMMXS4qW1XKaLpiKHVDXkJ223rfjdQTeeWM=
Message-ID: <84144f020512290006x71d2c245s5e148fae15720d59@mail.gmail.com>
Date: Thu, 29 Dec 2005 10:06:15 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: cai <junjiec@gmail.com>
Subject: Re: [RFC][fat] use mpage_readpage when cluster size is page-alignment
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43B3844A.5050401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ca992f110512272356l379dccc5k6288c28411ff7af4@mail.gmail.com>
	 <87u0ctwf93.fsf@devron.myhome.or.jp> <43B3844A.5050401@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/29/05, cai <junjiec@gmail.com> wrote:
> it should work, but maybe some performance loses if the
> cluster size is not page-alignment, for example, 4 sector/cluster
> in a 4KB/page system.
> because it will fall back to the block_read_full_page when
> non-adjacent block found in do_mpage_readpage, i think.
> the same applies to mpage_readpages too.

I am not sure I am following you. Shouldn't do_mpage_readpage work for
all adjacent blocks regardless of whether block size is page-aligned
or not? What's is the performance problem you're thinking of?

                            Pekka
