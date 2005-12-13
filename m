Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVLMKEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVLMKEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVLMKEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:04:47 -0500
Received: from web8610.mail.in.yahoo.com ([202.43.219.85]:30077 "HELO
	web8610.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932549AbVLMKEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:04:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nRRCUmW64gH/rA76STRFFJUZSKyTvJX5bufUpl67SHMklsOpkh7sC21FWPpc70rjE+s1tlMjufzVYPKTa6+dgwcctsfPe1ZIWphEnQ3V5Hu3y1a7BTRcKJG5Kc+voI1Qsm0+4lWyCTEsGeGaSPsUkm+IOmH1Nq5plJMZ3UW0Vks=  ;
Message-ID: <20051213095952.16201.qmail@web8610.mail.in.yahoo.com>
Date: Tue, 13 Dec 2005 01:59:52 -0800 (PST)
From: "Anand H. Krishnan" <anandhkrishnan@yahoo.co.in>
Subject: Re: Fwd: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
To: Ashutosh Naik <ashutosh.naik@gmail.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, rth@redhat.com, akpm@osdl.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <81083a450512130146j40a3f1ibc87350bdc9a6f11@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
> 
> Hi,
>         The check for exportsym not being NULL is
> redundant, since
> mod->num_syms will be 0 in that case.  The cast is
> also redundant.  You
> have two identical failure cases at the bottom. 

All true and will be changed.

> your use of index
> is convoluted: do it after relocations.
> 

Though rare, we will have the extra overhead of
relocations before we fail the loading of the m
odule [with the advantage of a cleaner code]. I
s that OK ?



Thanks,
Anand



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
