Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbWHDQAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbWHDQAu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWHDQAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:00:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:49042 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161265AbWHDQAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:00:50 -0400
From: Andreas Schwab <schwab@suse.de>
To: Jes Sorensen <jes@sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>
	<44BE9E78.3010409@garzik.org> <yq0lkq4vbs3.fsf@jaguar.mkp.net>
	<1154702572.23655.226.camel@localhost.localdomain>
	<44D35B25.9090004@sgi.com>
	<1154706687.23655.234.camel@localhost.localdomain>
	<44D36E8B.4040705@sgi.com>
X-Yow: This MUST be a good party -- My RIB CAGE is being painfully
 pressed up against someone's MARTINI!!
Date: Fri, 04 Aug 2006 18:00:24 +0200
In-Reply-To: <44D36E8B.4040705@sgi.com> (Jes Sorensen's message of "Fri, 04
	Aug 2006 17:58:03 +0200")
Message-ID: <je4pws1ofb.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sgi.com> writes:

> Alan Cox wrote:
>> Ar Gwe, 2006-08-04 am 16:35 +0200, ysgrifennodd Jes Sorensen:
>>> The proposed patch makes it u1 - if we end up with arch specific
>>> defines, as the patch is proposing, developers won't know for sure what
>>> the size is and will get alignment wrong. That is not fine.
>>
>> The _Bool type is up to gcc implementation details.
>
> Which is even worse :(

It's part of the ABI, just like any other C type.

>>> If we really have to introduce a bool type, at least it has to be the
>>> same size on all 32 bit archs and the same size on all 64 bit archs.
>>
>> You don't use bool for talking to hardware, you use it for the most
>> efficient compiler behaviour when working with true/false values.
>
> Thats the problem, people will start putting them into structs, and
> voila all alignment predictability has gone out the window.

Just like trying to predict the alignment of any other C type.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
