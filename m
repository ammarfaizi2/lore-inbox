Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbTEHNCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbTEHNCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:02:37 -0400
Received: from navigator.sw.com.sg ([213.247.162.11]:25478 "EHLO
	navigator.sw.com.sg") by vger.kernel.org with ESMTP id S261392AbTEHNCg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:02:36 -0400
From: Vladimir Serov <vserov@infratel.com>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <3EBA585A.7080704@infratel.com>
Date: Thu, 08 May 2003 17:15:06 +0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
References: <20030318155731.1f60a55a.skraw@ithnet.com>	<3E79EAA8.4000907@infratel.com>	<15993.60520.439204.267818@charged.uio.no>	<3E7ADBFD.4060202@infratel.com>	<shsof45nf58.fsf@charged.uio.no>	<3E7B0051.8060603@infratel.com>	<15995.578.341176.325238@charged.uio.no>	<3E7B10DF.5070005@infratel.com>	<15995.5996.446164.746224@charged.uio.no>	<3E7B1DF9.2090401@infratel.com>	<15995.10797.983569.410234@charged.uio.no>	<3EB91B6F.9020204@infratel.com> <16057.8409.117109.345706@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

>     > when things are OK. Also the rpc client in this request is
>     > c0d75060 which is mentioned in rpc queue status:
>
>     > -pid- proc flgs status -client- -prog- --rqstp- -timeout
>     > -rpcwait -action- --exit--
>     > 09150 0001 0000 000000 c0d75060 100003 c8f99074 00000000
>     > <NULL> c00f17b8 0
>
>
>Looks like there is a hanging GETATTR call from another process that
>is blocking your process.
>
>Which procedure does c00f17b8 correspond to? 
>
from the System.map :

c00f17b8 t call_status

Regards, Vladimir.
