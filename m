Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWJ3InR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWJ3InR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 03:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbWJ3InR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 03:43:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:60248 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964786AbWJ3InQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 03:43:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=JEKtrJen2KphFURmfw7JRKOoCAHcaatFGCvnlZShsghNTycB3DJ9NkWL6ai8D4bhMkyjMM78Ijh29DPSBC2/Si1GKXgAlLJiPoGoaFAKD/VyBECxXeo+bHUhRlXbaTr2hjUdcWYWz96lQtkFQdQy/nWdy0Hjaji6T+KatejAAhg=
Message-ID: <4545BB3E.7030503@innova-card.com>
Date: Mon, 30 Oct 2006 09:43:42 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: Franck Bui-Huu <vagabon.xyz@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>	 <453CE143.3070909@innova-card.com>	 <653402b90610230921j595446a4xda5e6d9444e108da@mail.gmail.com>	 <cda58cb80610230951l4a1319bbs6956fea5143c021a@mail.gmail.com>	 <653402b90610260745w59b740d2x5961e40252f5b76@mail.gmail.com>	 <cda58cb80610271308v137a2de8vfb8123a422270144@mail.gmail.com> <653402b90610271338t6e2e4d31idffefe4b6b1ce639@mail.gmail.com>
In-Reply-To: <653402b90610271338t6e2e4d31idffefe4b6b1ce639@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote:
> 
> Sorry, I meant: You can't mmap a RAM address using functions like the
> usual remap_pfn_range (as such functions doesn't like physical RAM
> addresses, they want I/O ports for example, like 0x378). So, you can't
> use smem_start. You need to code your own mmap & nopage function. (It
> is explained in LDD3 very well).
> 

well I must admit that I don't understand why... I suppose you refered
to that section in ldd3:

	An interesting limitation of remap_pfn_range is that it gives
	access only to reserved pages and physical addresses above the
	top of physical memory.

I take a quick look at the implementation of remap_pfn_range() and
there's no such limitation I can see (fortunately).

		Franck
