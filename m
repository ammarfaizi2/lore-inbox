Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSDCVGl>; Wed, 3 Apr 2002 16:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293276AbSDCVGa>; Wed, 3 Apr 2002 16:06:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21766 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291401AbSDCVGW>; Wed, 3 Apr 2002 16:06:22 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: tigran@aivazian.fsnet.co.uk (Tigran Aivazian)
Date: Wed, 3 Apr 2002 22:22:00 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        arjanv@redhat.com (Arjan van de Ven), hugh@veritas.com (Hugh Dickins),
        mingo@redhat.com (Ingo Molnar),
        stelian.pop@fr.alcove.com (Stelian Pop), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204032051530.1163-100000@einstein.homenet> from "Tigran Aivazian" at Apr 03, 2002 09:05:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ssCe-0004Xj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is wrong somewhere. Then perhaps we could even refine the API to have
> 
> EXPORT_SYMBOL_FRIENDS(sym,list_of_friends)
> 
> where only "friends" can use the symbol and even then only if they first
> call (an exported function):

Swap "friends" from people to code then its interesting

eg I'd love to be able to do
	EXPORT_SYMBOL_TO(sym, "i2o*.o");

for the i2o code and know that nobody is going to try and use those routines
for non i2o stuff thinking "that looks handy".

I'm not sure if its that managable, _INTERNAL works for a lot of things from
my point of view. Knowing what is and isnt claimed to be an interface helps
so much. Complicating it seems to have few extra payoffs
