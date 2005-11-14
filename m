Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVKNHWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVKNHWD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 02:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVKNHWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 02:22:03 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:63772 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750945AbVKNHWC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 02:22:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ka1nVytDrUGev7kO9f55bdPrxIXUR7aCcFmYuZRO34LhD4nu78YsmJqP+4Ye5wJdeUCMkgS257n71RIuEugPwwPQXcJ6AZHEkbjyzZHYspnSr8j9DTR2sa9B/82zR/ee4gFtispQDYdQLp7Nkgj0YiNPC9pcN7wObjhHFZefRUc=
Message-ID: <489ecd0c0511132322n4cfc0125r1358ba6136aaa0dc@mail.gmail.com>
Date: Mon, 14 Nov 2005 15:22:01 +0800
From: Luke Yang <luke.adi@gmail.com>
To: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <4375D8D4.9010605@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <20051101165136.GU8009@stusta.de>
	 <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
	 <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	 <20051104230644.GA20625@kroah.com>
	 <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
	 <20051107165928.GA15586@kroah.com>
	 <20051107235035.2bdb00e1.akpm@osdl.org>
	 <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com>
	 <4375D8D4.9010605@varma-el.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/05, Andrey Volkov <avolkov@varma-el.com> wrote:
> Luke Yang wrote:
> >>Does this architecture support SMP?  I see it's BROKEN_ON_SMP, but there
> >>seems to be some smp-style stuff in there.
> >
> >
> >    It doesn't support SMP now.
>
> Wrong, how about dual core BF56x subfamily? It's true SMP beast.
> Or you are try to told that "current SOFTWARE arch doesn't
> support it yet", am I right?

 Yes, BF56x does have two cores in one chip. But we are not going to
make it a SMP system. The second core is going to be used as a pure
DSP, do some encode/decode work. Remember Blackfin itself is a DSP
anyway.

>
> Also, returning to previous posts, ALL BF5xx have normal
> MMU (which possible not so useful for DSP tasks).

  Actually current BF5xx DSPs don't have a real MMU. It runs uClinux.
The called  "MMU" in the mannual is only a cache management and memory
protect unit, not a virtual memory unit.

>
> --
> Regards
> Andrey Volkov
>
>
