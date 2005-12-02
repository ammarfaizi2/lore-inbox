Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVLBM4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVLBM4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 07:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVLBM4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 07:56:45 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:62034 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750701AbVLBM4p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 07:56:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r4KIz5sKGlWMIAH8wfIvrrcu1mAwt4Eii1HMl0R0HEZ6zBfI7S8TCcmM5SPl6/43YjwOWb+Ri/JUcJOKpx2i6SMBH4Hzfa4U3PkUzCBfyIkM2EfOPnbIR8VBY99IxK3mwFEXin/DCxg5PCn0a7tL3cJpJbT8acvmdR38pTfrdpQ=
Message-ID: <2cd57c900512020456n2f31101k@mail.gmail.com>
Date: Fri, 2 Dec 2005 20:56:43 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: Use enum to declare errno values
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
In-Reply-To: <84144f020512020418x7ebf5e3bt54cde14ec6a7a954@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
	 <20051123233016.4a6522cf.pj@sgi.com>
	 <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>
	 <200512020849.28475.vda@ilport.com.ua>
	 <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
	 <84144f020512020418x7ebf5e3bt54cde14ec6a7a954@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/2, Pekka Enberg <penberg@cs.helsinki.fi>:
> Hi,
>
> 2005/12/2, Denis Vlasenko <vda@ilport.com.ua>:
> > > There is another reason why enums are better than #defines:
>
> On 12/2/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> > This is a reason why enums are worse than #defines.
> >
> > Unlike in other languages, C enum is not much useful in practices.
> > Maybe the designer wanted C to be as fancy as other languages?  C
> > shouldn't have had enum imho. Anyway we don't have any strong motives
> > to switch to enums.
>
> I don't follow your reasoning. The naming collision is a real problem
> with macros. With enum and const, the compiler can do proper checking
> with meaningful error messages. Please explain why you think #define
> is better for Denis' example?
>
>                                      Pekka
>

That is a bad bad style. It should be `#define FOO 123' if you have to
write it.

It's also hard to see what the confusing bar is "if you are looking at
file.c alone".

enum is worse than typdef.  Don't you see why we should use `struct
task_struct', rather than `task_t'?

Introducing enum alone can't solve the problems from bad macro usage
habits. Actually, it's not anything wrong with macros, it's
programers' bad coding style.

Macros play an important role in C, but enums don't.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
