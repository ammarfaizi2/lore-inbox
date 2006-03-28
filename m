Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWC1PCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWC1PCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWC1PCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:02:44 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:39790 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750754AbWC1PCn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:02:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OYWxDnNRt5rok87XhEfFskFYM4aHuF6hQ0uz/nwyVzBuz9dEW1vpfEkAY1AJ93Q42NmOeiI8RTkgn3nzSQ1CtHVluyQ9oyOZCQH0jhKfkOMWY/0StbDidxmoyrIzuPdA3aRbpumyOBnWdarMORXHjTgpmMPiZooFhAvKWLIehN8=
Message-ID: <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com>
Date: Tue, 28 Mar 2006 07:02:42 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Pierre PEIFFER" <pierre.peiffer@bull.net>
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>,
       jakub@redhat.com
In-Reply-To: <4428E7B7.8040408@bull.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4428E7B7.8040408@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/06, Pierre PEIFFER <pierre.peiffer@bull.net> wrote:
> I found a (optimization ?) problem in the futexes, during a futex_wake,
>   if the waiter has a higher priority than the waker.

There are no such situations anymore in an optimal userlevel
implementation.  The last problem (in pthread_cond_signal) was fixed
by the addition of FUTEX_WAKE_OP.  The userlevel code you're looking
at is simply not optimized for the modern kernels.
