Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWHBPdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWHBPdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWHBPdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:33:19 -0400
Received: from web25813.mail.ukl.yahoo.com ([217.146.176.246]:28532 "HELO
	web25813.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751215AbWHBPdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:33:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=Tpye4NwftnZDeDZKSJfcslD+fL+V6bzvMI8i6hS0XCJ7MbqZrdXLG4tyWTlq+SM8J95NrwL2JdxGAi1iSfkRTf69oRjd2A3MExof8FUMqCFl/v6rY8m4vVJgn+ixP3CRqZfgJ/SxGp4MeSm03yokzlk8llSr0uAUiFnEKloe/Xc=  ;
Message-ID: <20060802153316.7813.qmail@web25813.mail.ukl.yahoo.com>
Date: Wed, 2 Aug 2006 15:33:16 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : sparsemem usage
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
In-Reply-To: <1154532280.23655.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan !

Alan Cox wrote:
> The kernel allocates memory out using groups of blocks in a buddy
> system. 128K is smaller than one of the blocks so the kernel cannot
> handle this. 

As I wrote to Andy Whitcroft, I would think that the kernel forbid allocation
of blocks whose size is greater than the current memorysize. But I know 
nothing about the buddy allocator so I trust you ;)

> You need 2MB (if I remember right) granularity for your

MAX_ORDER is by default 11. Without changing this, I would say that I
need 4MB granularity.

> sections but nothing stops you marking most of the 2Mb section except
> the 128K that exists as "in use"

ok. But it will make pfn_valid() return "valid" for page beyond the first 128 KB.
Won't that result in bad impacts later ?

thanks

Francis



