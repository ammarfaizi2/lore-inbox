Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWI1KaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWI1KaE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 06:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWI1KaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 06:30:04 -0400
Received: from gw.goop.org ([64.81.55.164]:61327 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161058AbWI1KaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 06:30:01 -0400
Message-ID: <451BA434.9020409@goop.org>
Date: Thu, 28 Sep 2006 03:30:12 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
References: <451B64E3.9020900@goop.org> <20060927233509.f675c02d.akpm@osdl.org> <451B708D.20505@goop.org> <20060928000019.3fb4b317.akpm@osdl.org> <20060928071731.GB84041@muc.de> <20060928002610.05e61321.akpm@osdl.org> <20060928101555.GA99906@muc.de>
In-Reply-To: <20060928101555.GA99906@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> But no out of line section. So overall it's smaller, although the cache footprint
> is 2 bytes larger. But then is 2 bytes larger really an issue? We don't have
> _that_ many BUGs anyways.
>   

I think the out of line section is a feature; no point in crufting up 
the icache with BUG gunk, especially since a number of them are on 
fairly hot paths.

> I'll port the x86-64 way over to i386

It's neat, and it would solve my immediate problem, but I think my way 
is actually better.

    J
