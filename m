Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423303AbWJaN6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423303AbWJaN6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423305AbWJaN6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:58:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:4938 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423303AbWJaN6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:58:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GJwYgN1lkSIRs0vTx8uGC/9j0T5ua7jaix6CyhzdnSyGNidrF48P5n9KxoSnu69VIVNIV0DiVz2JCXcATcwHfA2JCWwfCSO7KF2d0klXOladHnyYqiMuc8zY5DzcdeECmS+PoBwm8RDDz9Jxbp6Eic2N44YKQvIK5400lP/PWJc=
Message-ID: <653402b90610310558o40898827id1fe2ea0e1f28c2a@mail.gmail.com>
Date: Tue, 31 Oct 2006 14:58:53 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 update4] drivers: add LCD support
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <45470DB8.5020906@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061026174858.b7c5eab1.maxextreme@gmail.com>
	 <20061026220703.37182521.akpm@osdl.org>
	 <4545C756.30403@innova-card.com>
	 <653402b90610300553t405c67e6u69dee3c83c22dae5@mail.gmail.com>
	 <45470DB8.5020906@innova-card.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Miguel Ojeda wrote:
> > Again: Please read LDD3. It explains it well. Read all the "Remapping
> > RAM" chapter and you will understand what I've done, or just try to
> > remap RAM yourself with remap_pfn_range.
>
> Well, I'm trying to get an explanation here and here is what I get
> from you:
>
> MO  > LDD3 states it must work like this. (Note: it doesn't explain
>       why though)
> FBH > Weird I read the implementation of remap_pfn_range() and it
>       doesn't seem to have such restriction, I'm wondering how
>       things work...
> MO  > Again it's stated in LDD3, read again.
>
> Do you really think you explain anything with such replies ?
>

Do you really think I have to explain anything with my replies? I was
just trying to help you telling where I found the answer.

Anyway, isn't it explained in LDD3? isn't it stated in LDD3? I think
it is (yep, not deeply, but enough: other books cover that points
better and a device driver programmer doesn't have to know about
implementations, right?). Sure, neither the book or I didn't know
about the VM_PFNMAP change, but that doesn't change that I was trying
to encourage you to read such chapter, the same way I found the answer
there.

>
> Fortunately, Hugh Dickins gives a hint and it appears that the
> restriction doesn't hold anymore.
>
> > (I really tried it using
> > different ways and I couldn't map it with remap_pfn_range, it returns
> > you a place full with zeros, as LDD3 states).
>
> I'm really wondering how did you test the thing... ;)
>

And I still say I tried it, many ways, using remap_pfn_range() and
other weird things also. Finally, I thought something was wrong, so I
read LDD3 and I found the explanation about why my code mmap couldn't
mmap RAM. Also, my area was full of zeros, as LDD3 states. So I read a
little further and I did what "Remapping RAM" explains.

Anything else?

Bye,
       Miguel Ojeda
