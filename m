Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVBYPPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVBYPPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVBYPO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:14:58 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:58869 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262714AbVBYPOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:14:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rdva0SmgymppFhSNwYI4iDRY54lnDGFXRsjnaIdHaHdKek2aPF0vN3ZjPB/D1menZmkCbJrVIRTMGw265/Nr8J5Uy2IaZbcm8UGdl8cdkexmf7QqHw9KqLJ57XOA8F8G8jx2LqGkk2gXdrIGnAf3J3wY9Mwcw3fzyo7mLc5srNk=
Message-ID: <3f250c7105022507146b4794f1@mail.gmail.com>
Date: Fri, 25 Feb 2005 11:14:36 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] A new entry for /proc
Cc: hugh@veritas.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       rrebel@whenu.com, marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
In-Reply-To: <20050224035255.6b5b5412.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
	 <3f250c710502220513179b606a@mail.gmail.com>
	 <3f250c71050224003110e74704@mail.gmail.com>
	 <20050224010947.774628f3.akpm@osdl.org>
	 <3f250c710502240343563c5cb0@mail.gmail.com>
	 <20050224035255.6b5b5412.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I tested the two smaps entry using time command.

I tested 100.000 cat commands with smaps for each version.

I checked the difference between the two versions and the new one is
faster than old one. So Hugh is correct about the loop performance.

Thanks!!!

Mauricio Lin.

On Thu, 24 Feb 2005 03:52:55 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Mauricio Lin <mauriciolin@gmail.com> wrote:
> >
> > But can i use jiffies to measure this kind of performance??? AFAIK, if
> >  it is more efficient, then it is faster, right? How can I know how
> >  fast it is? Any idea?
> 
> umm,
> 
> time ( for i in $(seq 100); do; cat /proc/nnn/smaps; done > /dev/null )
> 
> ?
>
