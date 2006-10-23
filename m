Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWJWWKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWJWWKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWJWWKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:10:50 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:2266 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1751507AbWJWWKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:10:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eyz2a9VtIhDGOTqWfC6zo/CYjKTcUdlKQSp7lTIFUAGGftE7ZooI7mIwlnjqfLn+/cPSDzzSwlgws/zWctJSoK5qMkonQxn5t8c39AWMNHCTGqc4960w0SrUJ9OA90LPJIOFaeafQfSjwAi21AFzNFVJREBXFl0tOq9V+1ZayVU=
Message-ID: <69304d110610231508s73ee1bc5x7e8c1da37974d986@mail.gmail.com>
Date: Tue, 24 Oct 2006 00:08:02 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Avi Kivity" <avi@qumranet.com>
Subject: Re: [PATCH 8/13] KVM: vcpu execution loop
Cc: "Arnd Bergmann" <arnd@arndb.de>, linux-kernel@vger.kernel.org
In-Reply-To: <453D2FFA.3040506@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <453CC390.9080508@qumranet.com> <200610232141.45802.arnd@arndb.de>
	 <453D230D.7070403@qumranet.com> <200610232229.41934.arnd@arndb.de>
	 <453D27F8.8020509@qumranet.com>
	 <69304d110610231402k7913df63l7e493f95b5d92911@mail.gmail.com>
	 <453D2FFA.3040506@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Avi Kivity <avi@qumranet.com> wrote:
> Antonio Vargas wrote:
> >>
> >> I could do that, but I feel that's more brittle.  I might need more (or
> >> other) fields later on.  It will also cost me more  pushes on the stack
> >> (no real performance or space impact, just C64-era frugality).
> >
> > maybe thats the mindsent needed to make these virtual cpu patches
> > without eating away all the cpu power with more than needed
> > abstractions ;)
> >
>
> Unfortunately not.  Saving a cycle or two doesn't help when a vm exit
> costs thousands of cycles, and worse, kills your tlb.
>
> The key is eliminating unnecessary exits.  I have plans for massively
> optimizing the mmu virtualization, and the next AMD core will do that in
> hardware (look for a "nested page tables" sticker before you buy).

yes, when I read the nested pages description in amd docs, i wondered
that the intel had nothing like that and would go much slower... amd
has worked a lot on the mmu things (like cr3-keyed tlb on k8 systems
to avoid emptying always at switch)

> --
> Do not meddle in the internals of kernels, for they are subtle and quick to panic.
>
>


-- 
Greetz, Antonio Vargas aka winden of network

http://network.amigascne.org/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
