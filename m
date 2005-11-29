Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVK2Oj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVK2Oj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVK2Oj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:39:28 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:11365 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751357AbVK2Oj2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:39:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WUmy6EzVcZ0NIlGeqezvBOMP29YYdBrhA38Yyl2EvTwA0Tsi0hmASWRRNYa2+VCKJMozpFWVaIQtcUJLIoone+viv2eqbI5hmLepn1Th14XnnoRSjLI3QVjc8qKgcu3PX682iYqZHMErpc7lOal6hpQQZs1UvwKTxOZbUUBVuhc=
Message-ID: <121a28810511290639g79617c85h@mail.gmail.com>
Date: Tue, 29 Nov 2005 15:39:26 +0100
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] race condition in procfs
Cc: vserver@list.linux-vserver.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1133274524.6328.56.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	 <20051129000916.6306da8b.akpm@osdl.org>
	 <121a28810511290038h37067fecx@mail.gmail.com>
	 <121a28810511290525m1bdf12e0n@mail.gmail.com>
	 <121a28810511290604m68c56398t@mail.gmail.com>
	 <1133274524.6328.56.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/29, Steven Rostedt <rostedt@goodmis.org>:
> Have you seen this crash the vanilla kernel?  What exactly are you doing
> to see the crash? If you have a script or something, could you post it.
> I could spend some time helping you debug it too on one of my SMP boxes.
>

I'm not really using vanilla 2.6 kernels and my setup would be quite
hard to run on a vanilla kernel.

The reproduceability of this bug varies. Sometimes it'll go for a few
days without happening, sometimes it's a matter of a few minutes. I'm
beginning to feel it's a vserver issue after all, somehow related to
pid virtualisation (it maps some vxi->vx_initpid to 1).

Thus I cannot provide a simple script to trigger the bug (I wish I
could) but often doing a -j8 kernel compile in a vserver is enough.
