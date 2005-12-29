Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVL2ItX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVL2ItX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVL2ItW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:49:22 -0500
Received: from c158129.vh.plala.or.jp ([210.150.158.129]:32199 "EHLO
	mvs1.plala.or.jp") by vger.kernel.org with ESMTP id S965062AbVL2ItW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:49:22 -0500
Message-ID: <43B3A3D8.6050605@gmail.com>
Date: Thu, 29 Dec 2005 17:52:40 +0900
From: cai <junjiec@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][fat] use mpage_readpage when cluster size is page-alignment
References: <ca992f110512272356l379dccc5k6288c28411ff7af4@mail.gmail.com>	 <87u0ctwf93.fsf@devron.myhome.or.jp> <43B3844A.5050401@gmail.com> <84144f020512290006x71d2c245s5e148fae15720d59@mail.gmail.com>
In-Reply-To: <84144f020512290006x71d2c245s5e148fae15720d59@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

>I am not sure I am following you. Shouldn't do_mpage_readpage work for
>all adjacent blocks regardless of whether block size is page-aligned
>or not? What's is the performance problem you're thinking of?
>
>                            Pekka
>
>  
>
no, not block size but cluster size
as you know, in FAT, file is organized in clusters
and one cluster could have N blocks(sectors).
so if cluster size is not page-aligned,
a page may live in non-adjacent blocks, and
do_mpage_readpage has to fall back to block_read_full_page
in this case.

thanks.
                                   junjie

