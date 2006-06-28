Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbWF1BP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWF1BP4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 21:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWF1BP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 21:15:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18836 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932666AbWF1BPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 21:15:55 -0400
Date: Tue, 27 Jun 2006 18:15:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
cc: Sam Ravnborg <sam@ravnborg.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom-killer problem
In-Reply-To: <200606271421.45497.daniel.ritz-ml@swissonline.ch>
Message-ID: <Pine.LNX.4.64.0606271807570.3927@g5.osdl.org>
References: <200606270028.16346.daniel.ritz-ml@swissonline.ch>
 <Pine.LNX.4.64.0606261604180.3927@g5.osdl.org> <20060627053950.GA26435@mars.ravnborg.org>
 <200606271421.45497.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jun 2006, Daniel Ritz wrote:
>  
>  # Default for not multi-part modules
> -modname = $(basetarget)
> +modname = $(basename $(basetarget))

Is there some way to make it clear _what_ the suffix we expect to remove 
actually is in GNU make? Ie the "shell" kind of "basename" logic.

Ie, I'd personally be happier with a 

	modname = $(basename $(basetarget) .mod)

kind of thing (yeah, this obviously does _not_ work)

Gah. I've happily been trying to avoid having to know all the GNU Makefile 
magic. Sam, does Dans patch make sense and can you explain what went 
wrong? I'd happily revert the revert and instead use Dans patch, I just 
want to understand it..

		Linus
