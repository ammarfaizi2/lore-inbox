Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWJ3NfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWJ3NfF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWJ3NfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:35:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:22127 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932173AbWJ3NfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:35:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WYhVZ0xtoJegtwJVKmJ9CBZT6gY7ZfwpU2SlK3JPx3EUUtFOmMub2+ia4nN67cJcRrWaRN2PeeOxEc7Ga1RvvD57NiYmYbFcMi8XRm2KJDkJ9pvci0umeJ7kfaLdTHblAI3SBp+j5UT2dtbcwR134whawPzHeEqfFU6X9QVnPJ4=
Message-ID: <653402b90610300535n6d26be8fr29df1c491f033533@mail.gmail.com>
Date: Mon, 30 Oct 2006 14:35:01 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <4545BB3E.7030503@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE143.3070909@innova-card.com>
	 <653402b90610230921j595446a4xda5e6d9444e108da@mail.gmail.com>
	 <cda58cb80610230951l4a1319bbs6956fea5143c021a@mail.gmail.com>
	 <653402b90610260745w59b740d2x5961e40252f5b76@mail.gmail.com>
	 <cda58cb80610271308v137a2de8vfb8123a422270144@mail.gmail.com>
	 <653402b90610271338t6e2e4d31idffefe4b6b1ce639@mail.gmail.com>
	 <4545BB3E.7030503@innova-card.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Miguel Ojeda wrote:
> >
> > Sorry, I meant: You can't mmap a RAM address using functions like the
> > usual remap_pfn_range (as such functions doesn't like physical RAM
> > addresses, they want I/O ports for example, like 0x378). So, you can't
> > use smem_start. You need to code your own mmap & nopage function. (It
> > is explained in LDD3 very well).
> >
>
> well I must admit that I don't understand why... I suppose you refered
> to that section in ldd3:
>
>         An interesting limitation of remap_pfn_range is that it gives
>         access only to reserved pages and physical addresses above the
>         top of physical memory.
>
> I take a quick look at the implementation of remap_pfn_range() and
> there's no such limitation I can see (fortunately).
>
>                 Franck
>

Read further ;-)

      "Therefore, remap_pfn_range won't allow you to remap
conventional addresses, which include the ones you obtain by calling
get_free_pages"

Because of such limitation, they teach you to remap RAM in other ways.
