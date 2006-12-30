Return-Path: <linux-kernel-owner+w=401wt.eu-S1030278AbWL3FuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWL3FuY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 00:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWL3FuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 00:50:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:16950 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030278AbWL3FuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 00:50:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uDvXM5mjXxvg2pkMvR+3obqg8YRYOHidFpBlIuycODhaeKeZsX7DjNUQ9UnzoUHkGu6mmUWrAo3Oxy2EiyyPbs9hNRTgZ2o8Ofr2LoTorqrz+CJDsXI7NiE25OiVIuXRtoDxiv9BLF6rmEe2JjhQIqxLt34iUh+z+DtYSmO38bc=
Message-ID: <67029b170612292150q7f59390cp83f35698ac7f7bd7@mail.gmail.com>
Date: Sat, 30 Dec 2006 13:50:21 +0800
From: "Zhou Yingchao" <yingchao.zhou@gmail.com>
To: "yunfeng zhang" <zyf.zeroos@gmail.com>
Subject: Re: [PATCH 2.6.16.29 1/1] memory: enhance Linux swap subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4df04b840612261933g6eab036rb474930828dadb6d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840612260018u4be268cod9886edefd25c3a@mail.gmail.com>
	 <67029b170612260103o9193346hde726a3f09afa57f@mail.gmail.com>
	 <4df04b840612261933g6eab036rb474930828dadb6d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/12/27, yunfeng zhang <zyf.zeroos@gmail.com>:
> To multiple address space, multiple memory inode architecture, we can introduce
> a new core object -- section which has several features
Do you mean "in-memory inode"  or "memory node(pglist_data)" by "memory inode" ?
> The idea issued by me is whether swap subsystem should be deployed on layer 2 or
> layer 3 which is described in Documentation/vm_pps.txt of my patch. To multiple
> memory inode architecture, the special memory model should be encapsulated on
> layer 3 (architecture-dependent), I think.
I guess that you are  wanting to do something to remove arch-dependent
code in swap subsystem.  Just like the pud introduced in the
page-table related codes. Is it right?
However, you should verify that your changes will not deteriorate
system performance. Also, you need to maintain it for a long time with
the evolution of mainline kernel before it is accepted.

Best regards
-- 
Yingchao Zhou
***********************************************
 Institute Of Computing Technology
 Chinese Academy of Sciences
***********************************************
