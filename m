Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVJBS5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVJBS5c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 14:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVJBS5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 14:57:32 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:44869 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751143AbVJBS5c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 14:57:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HOo8lkQwv10fkpVDGuuP+j0cYInBrb3qNay+TAK8FEUFSK7WSQ4sOuC1WMA/gY5EMQlwIuGLRq5WJmjc5WOmIwM39kAlrUfQLlP/BeElvosxVrwYrnPTBnvOIPucR8zKoVaJ29Kd5ZMQ6QoC00Dfg5SN6/bPGqULk6FHGc1ff4c=
Message-ID: <35fb2e590510021157l63f6a270l2810659427a8fa9e@mail.gmail.com>
Date: Sun, 2 Oct 2005 19:57:30 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Discontiguous memory fun
In-Reply-To: <35fb2e5905090110171aa77266@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e5905090110171aa77266@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to my own post...

On 9/1/05, Jon Masters <jonmasters@gmail.com> wrote:

>  I've got a hardware platform based on an ARM922, a bit like Excalibur,
> which has a nice large hole in memory:
>
>  0x0000_0000 - 32MB (or whatever) of SDRAM.
>  0x8000_0000 - 64MB (or whatever) of SDRAM.

I fixed it using a bodge similar to PHYS_OFFSET and disabled the lower
bank of memory if the kernel was booted at the higher address since it
was extremely difficult to play with the half-support for discontig in
old 2.4 ARM kernels (all of the existing boards are just playing a
game of luck with their memory/node mappings) without a working BDI.

I'd love to know what the state of discontig memory is like on 2.6
series ARM kernels and highmem too for that matter, but I've not had
chance to look at it (I'm usually a ppc guy).

Jon.
