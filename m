Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWHRQmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWHRQmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWHRQmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:42:53 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:48649 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751416AbWHRQmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:42:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V36oyfhkvr4lGcP0KogBO9rBWM7TRbxqbDG6EOLSBL9C8o7IAQgDl9rf+7nVfXJRSk4Snol4+mtdqASWYyq6HUUYAIvDhOnsfnizP+EEfMQiKyVAStGVmRBYoBD/RNp9AaU8ecH2UZYysvYPR1kGZituV7jM2vVCLoTUBtLzplo=
Message-ID: <6bffcb0e0608180942l12e342epd60dffbb5c5d4b3e@mail.gmail.com>
Date: Fri, 18 Aug 2006 18:42:51 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0608180846s4ed560b7ld4e3081bdc754454@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <b0943d9e0608170602v13dea49bgf64dbf17b7a52273@mail.gmail.com>
	 <6bffcb0e0608170745s8145df4ya4e946c76ab83c1b@mail.gmail.com>
	 <b0943d9e0608170801v23592952scf12c2c0b4a7bf4@mail.gmail.com>
	 <b0943d9e0608171458l45b717bexbfb8fb2ba68228db@mail.gmail.com>
	 <6bffcb0e0608180528ocadc36ck8868ae1a33342bb9@mail.gmail.com>
	 <b0943d9e0608180627g61007207read993387bf0c0b4@mail.gmail.com>
	 <6bffcb0e0608180655j50332247m8ed393c37d570ee4@mail.gmail.com>
	 <6bffcb0e0608180715v27015481vb7c603c4be356a21@mail.gmail.com>
	 <b0943d9e0608180846s4ed560b7ld4e3081bdc754454@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 18/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > Lockdep still detects this bug
> >
> > =======================================================
> > [ INFO: possible circular locking dependency detected ]
> > -------------------------------------------------------
> > events/0/8 is trying to acquire lock:
> >  (memleak_lock){++..}, at: [<c0176a11>] memleak_free+0x9e/0x16f
> >
> > but task is already holding lock:
> >  (&parent->list_lock){++..}, at: [<c0174f29>] drain_array+0x49/0xad
> >
> > which lock already depends on the new lock.
> > etc.
>
> Do you have the complete dmesg output? There should be a different
> path which I missed (I didn't get this yestarday but I haven't tried
> with the latest patch I sent to you today).

Here is dmesg output
http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.9/kml-dmesg2

>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
