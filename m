Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWGJKBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWGJKBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWGJKBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:01:38 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:37411 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751342AbWGJKBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:01:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U3CX9hwnzMuBBauJgQFk5b4U6EcgyR2JyUs7ruLwkx3Ul2YwKMl3saK5fkndiuaWRR8ni698c1j3BjJLfh6bNeHyK7XwFSLvh8Ry90Wm1d4nS2AQTxaGK0cJYg4KBhVt4UlFO7Vg+KaVzFIktMOuspAN8Xmzmarihl1HXQgO+nk=
Message-ID: <6bffcb0e0607100301j1fa444au2c3ecd7128e126ef@mail.gmail.com>
Date: Mon, 10 Jul 2006 12:01:37 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-rc1-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060710092528.GA8455@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <6bffcb0e0607090332i477d594fq9ef96721574ae91b@mail.gmail.com>
	 <20060709035203.cdc3926f.akpm@osdl.org>
	 <20060710074039.GA26853@elte.hu>
	 <6bffcb0e0607100222m5cbdba31ia39d47f3f1f94b26@mail.gmail.com>
	 <20060710092528.GA8455@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > >> rofl.  You broke lockdep.
> > >
> > >ouch! the lock identifications look quite funny :-| Never saw that
> > >happen before,
> >
> > :)
> >
> > >i'm wondering what's going on. Michal, did this happen
> > >straight during bootup? Or did you remove/recompile/reinsert any modules
> > >perhaps?
> >
> > It's happening while /etc/init.d/cpuspeed execution.
> >
> > I forgot about "make O=/dir/ clean". When new -mm is out I always
> > remove kernel directory and create new one.
>
> ah, ok. So i'll put this under the 'unclean-build artifact' section,
> i.e. not a lockdep bug for now, it seems. Please re-report if it ever
> occurs again with a clean kernel build.

Unfortunately "make O=/dir clean" doesn't help. I'll disable lockdep,
and see what happens.

>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
