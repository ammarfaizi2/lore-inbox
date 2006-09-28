Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751717AbWI1HRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbWI1HRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWI1HRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:17:33 -0400
Received: from colin.muc.de ([193.149.48.1]:10767 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751717AbWI1HRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:17:32 -0400
Date: 28 Sep 2006 09:17:31 +0200
Date: Thu, 28 Sep 2006 09:17:31 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
Message-ID: <20060928071731.GB84041@muc.de>
References: <451B64E3.9020900@goop.org> <20060927233509.f675c02d.akpm@osdl.org> <451B708D.20505@goop.org> <20060928000019.3fb4b317.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928000019.3fb4b317.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Plan #17 is to just put the BUG inline and then put the EIP+file*+line into
> a separate section, then search that section at BUG time to find the record
> whose EIP points back at this ud2a.
> 
> It's a bit messy for modules, but it minimises the .text impact and keeps
> disassembly happy, no?
> 
> And if done right it can probably be used by other architectures.


The way x86-64 solved it was to turn the inline code into valid
instructions. This can be done with two additional bytes.
IMHO that's the right solution for the problem on i386 too

-Andi

