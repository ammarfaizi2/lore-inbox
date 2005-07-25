Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVGYNms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVGYNms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 09:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVGYNms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 09:42:48 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:20047 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261173AbVGYNmr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 09:42:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fcsy/1qzeSqd9FscUbsiVR4fC4BiCzslXyk21eWCM/F/F7aSHR665EsBahnNAhEHDEB0O3bHJuYoGi8hDmnpR1XlnNDrVk8Tqnc4jYg8r7SDzVzJZPCrDePnoroYuTYcIB9+2GZSD1jxFDpZi/Cnp2Yh2KSp+80eC7ImfVSxJSI=
Message-ID: <4536bb73050725064273cdbb50@mail.gmail.com>
Date: Mon, 25 Jul 2005 19:12:47 +0530
From: VASM <vasm85@gmail.com>
Reply-To: VASM <vasm85@gmail.com>
To: Nix <nix@esperi.org.uk>
Subject: Re: kernel page size explanation
Cc: Jesper Juhl <jesper.juhl@gmail.com>, gbakos@cfa.harvard.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <878xzvc2qs.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.SOL.4.58.0507211925170.28852@titan.cfa.harvard.edu>
	 <9a87484905072118207a85970e@mail.gmail.com>
	 <87d5p8aw4h.fsf@amaterasu.srvr.nix>
	 <4536bb7305072412011fbeaf59@mail.gmail.com>
	 <878xzvc2qs.fsf@amaterasu.srvr.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/05, Nix <nix@esperi.org.uk> wrote:
> On Mon, 25 Jul 2005, VASM wrote:
> > i had one question
> > does the linux kernel support only one default page size even if the
> > processor on which it is working supports multiple ?
> 
> No. Some architectures have compile-time support for multiple different
> page sizes (e.g. Itanium, SPARC64); many have support for a
> (non-swappable) `large pages) system, and a filesystem backed by huge
> pages. (Often, the kernel is stored in huge pages, to keep the number
> of page table entries wasted by the nonswappable kernel to a minimum.)
> 
> What is *not* presently supported is using multiple page sizes to
> back userspace processes; that size is currently fixed at compile-time,
> even on architectures supporting multiple variably-sized pages.
> 
are there any specific reasons for not using large page size for
userspace processes

> --
> `But of course, GR is the very best relativity for the masses.'
>  --- Wayne Throop
>
