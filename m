Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUFHJCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUFHJCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbUFHJCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:02:49 -0400
Received: from colin2.muc.de ([193.149.48.15]:38674 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264900AbUFHJCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:02:48 -0400
Date: 8 Jun 2004 11:02:47 +0200
Date: Tue, 8 Jun 2004 11:02:47 +0200
From: Andi Kleen <ak@muc.de>
To: ingo@pyrillion.org
Cc: Andi Kleen <ak@muc.de>, j.dittmer@portrix.net,
       linux-kernel@vger.kernel.org
Subject: Re: Re: new icc kernel patch available (with kernel PGO)
Message-ID: <20040608090247.GB659@colin2.muc.de>
References: <5685161$108663562940c4be6d58edc6.52713007@config7.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5685161$108663562940c4be6d58edc6.52713007@config7.schlund.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 09:20:02PM +0200, ingo@pyrillion.org wrote:
> as I stated before, I created a generic training set in phase 2 of the
> three phases compilation process by utilizing the kernel in various
> ways: fore- and background activities, networking, filesystems, etc.

Ok.

> The PGO kernel module and the PGO daemon pgod are included in the
> newest patch. You can create your own specialized training set for your
> specific task. That's the big advantage of kernel PGO. This is the
> first patch using both technologies of the Intel C/C++ Compiler, IPO
> (Inter Procedural Optimization) and PGO (Profile Guided Optimization),
> together.

gcc supports PGO and even some forms of IPO just fine too, but it was never 
done because it causes maintainability issues (nobody can reproduce your binary
image anymore, which makes it extremly hard to reproduce an oops) 

BTW Someone pointed out that you're using flags to enable ansi aliasing
in your patchkit. That's an extremly bad idea, because the kernel
is not ANSI alias clean at all. If it worked you were quite lucky.

-Andi
