Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWGKVy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWGKVy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWGKVy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:54:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:53005 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932159AbWGKVyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:54:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YltCRtXlOl2CplgmpODwddMX/sNz6B21vQamVcNZHzX6d4E4bQN29HJNPt+r/Tpjz38koy20WJwNkl1UANCa/96/zf0xhNbugN+9ITMN2QgrEZ8S1j7cB0q83UxySGxDJrFiLCXnb13D0x+/zpC0bF+wOTL31CE0pf6+G7TYV/0=
Message-ID: <b0943d9e0607111454l1f9919eahbb3b683492a651e@mail.gmail.com>
Date: Tue, 11 Jul 2006 22:54:55 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110617g36f7123dm2b5f0e88b10cbcaa@mail.gmail.com>
	 <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
	 <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
	 <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
	 <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
	 <b0943d9e0607110844m6278da6crdc03bccce420da1d@mail.gmail.com>
	 <6bffcb0e0607110902u4e24a4f2jc6acf2eb4c3bae93@mail.gmail.com>
	 <b0943d9e0607110931n4ce1c569x83aa134e2889926c@mail.gmail.com>
	 <6bffcb0e0607111000q228673a9kcbc6c91f76331885@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal,

On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > It looks like there are some reports in __alloc_skb. Please try the
> > attached patch.
>
> Here is the result
> http://www.stardust.webpages.pl/files/o_bugs/kml/ml4.txt

Some of the __alloc_skb disappeared but there are still a lot of
context_struct_to_string (812). Could you let it running for a bit to
get more reported leaks (few thousands) and send me the contents of
the /proc/slabinfo file (together with the memleak file)? I want to
make sure whether it is a kmemleak problem or not.

Thanks.

-- 
Catalin
