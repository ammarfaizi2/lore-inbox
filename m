Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVL2Gep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVL2Gep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 01:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVL2Gep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 01:34:45 -0500
Received: from c158132.vh.plala.or.jp ([210.150.158.132]:45822 "EHLO
	mvs4.plala.or.jp") by vger.kernel.org with ESMTP id S965038AbVL2Geo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 01:34:44 -0500
Message-ID: <43B3844A.5050401@gmail.com>
Date: Thu, 29 Dec 2005 15:38:02 +0900
From: cai <junjiec@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][fat] use mpage_readpage when cluster size is page-alignment
References: <ca992f110512272356l379dccc5k6288c28411ff7af4@mail.gmail.com> <87u0ctwf93.fsf@devron.myhome.or.jp>
In-Reply-To: <87u0ctwf93.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

>Can't we use mpage_readpage() always? IIRC, that should work fine
>without disadvantage.
>
>Thanks.
>  
>
it should work, but maybe some performance loses if the
cluster size is not page-alignment, for example, 4 sector/cluster
in a 4KB/page system.
because it will fall back to the block_read_full_page when
non-adjacent block found in do_mpage_readpage, i think.
the same applies to mpage_readpages too.

thanks.
                                      junjie

