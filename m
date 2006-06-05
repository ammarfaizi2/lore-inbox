Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750983AbWFELd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWFELd1 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWFELd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:33:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:9652 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750982AbWFELd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:33:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QAKIEovh/rBImmi1CKVefWhFjpUwGAakQXMHdFqLDUpe3JewKSKtahGfZlv6EC2ovgechYTQDWbKisiBkFhr7O1tNXZ8Jyxqva/KsikGCgSVgnK26rm+jQU+MompE8K27K2TRlJPnfpQHoI+UVXPoe/guHaZ2DYe4RWYwZgq0M4=
Message-ID: <6bffcb0e0606050433i1261d3e4sd0d958fb15208596@mail.gmail.com>
Date: Mon, 5 Jun 2006 13:33:25 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch, -rc5-mm3] fix IDE deadlock in error reporting code
Cc: "Andrew Morton" <akpm@osdl.org>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20060605083530.GA31738@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com>
	 <20060604024937.0fb57258.akpm@osdl.org>
	 <6bffcb0e0606040308j28d9e89axa0136908c5530ae3@mail.gmail.com>
	 <20060604104121.GA16117@elte.hu>
	 <6bffcb0e0606040407u4f56f7fdyf5ec479314afc082@mail.gmail.com>
	 <20060604213803.GC5898@elte.hu>
	 <6bffcb0e0606041535u10fdb7c2o9ac38d6fb80fd28d@mail.gmail.com>
	 <20060605083016.GA31013@elte.hu> <20060605083530.GA31738@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/06/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
> > ah. That's a real deadlock scenario. Does the patch below fix it? If
> > yes then i think this is a candidate for 2.6.17 merging too.
>
> actually, the replacement patch below is better i think - it moves the
> ide_lock taking to outside the printing section. That should still be OK
> as we dont call other functions from within the section, and it should
> also result in slightly more robust printing, as the whole printing code
> will be atomic under ide_lock.

Probably fixed, thanks.

>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
