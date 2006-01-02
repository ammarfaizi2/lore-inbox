Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWABMJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWABMJc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 07:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWABMJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 07:09:32 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:8140 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932120AbWABMJb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 07:09:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j/AzEhZjTXHNx0HlEA7+7bKxScDpnPjYZE0oV3kGFGD8T8iyoS8RwzT85eqgjRB+soSiTknvZ5MScyOIRaAwra4zpFUcVTfr3kY0PdOKLBXlvU30vXgHu8U3SDJL7aTdzS9TBva5kcueRhctS6mjLFV2pdOiwoeH28IUd8r+41o=
Message-ID: <84144f020601020409j3013f7e7w8c242bbb488f013@mail.gmail.com>
Date: Mon, 2 Jan 2006 14:09:29 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on interactive response
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43ABFD47.3080000@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43A8EF87.1080108@bigpond.net.au> <43AB29B8.7050204@bigpond.net.au>
	 <1135292364.9769.58.camel@lade.trondhjem.org>
	 <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com>
	 <1135297525.3685.57.camel@lade.trondhjem.org>
	 <43AB69B8.4080707@bigpond.net.au>
	 <1135330757.8167.44.camel@lade.trondhjem.org>
	 <43ABD639.2060200@bigpond.net.au>
	 <1135342262.8167.143.camel@lade.trondhjem.org>
	 <43ABFD47.3080000@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trond Myklebust wrote:
> >         /*
> >          * Tasks that have marked their sleep as noninteractive get
> >          * woken up without updating their sleep average. (i.e. their
> >          * sleep is handled in a priority-neutral manner, no priority
> >          * boost and no penalty.)
> >          */
> >
> > This appears to be the only documentation for the TASK_NONINTERACTIVE
> > flag,

On 12/23/05, Peter Williams <pwil3058@bigpond.net.au> wrote:
> I guess it makes to many assumptions about the reader's prior knowledge
> of the scheduler internals.  I'll try to make it clearer.

FWIW, Ingo invented TASK_NONINTERACTIVE to fix a problem I had with
Wine. See the following threads for further discussion:

http://marc.theaimsgroup.com/?t=111729237700002&r=1&w=2
http://marc.theaimsgroup.com/?t=111761183900001&r=1&w=2

                                 Pekka
