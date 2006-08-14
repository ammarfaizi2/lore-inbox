Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751966AbWHNJUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbWHNJUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 05:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWHNJUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 05:20:04 -0400
Received: from mx1.suse.de ([195.135.220.2]:15773 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751942AbWHNJUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 05:20:03 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: module compiler version check still needed?
Date: Mon, 14 Aug 2006 11:19:46 +0200
User-Agent: KMail/1.9.3
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200608130648.36178.ak@suse.de> <1155546377.2886.190.camel@laptopd505.fenrus.org>
In-Reply-To: <1155546377.2886.190.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608141119.46259.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 11:06, Arjan van de Ven wrote:
> On Sun, 2006-08-13 at 06:48 +0200, Andi Kleen wrote:
> > Does anybody know of any reason why we would still need the compiler version
> > check during module loading? AFAIK on i386 it was only needed to handle
> > 2.95 (which got dropped) and on x86-64 it was never needed. Is there
> > a need on any other architecture for it?
> 
> is there any harm in doing this check?

Yes, it can cause lots of trouble when you try to compile external
modules on a different system with different compiler than on the
system where the kernel was compiled.

e.g. you upgrade a distribution kernel but now you can compile
modules for it because the new rpm was compiled with a newer 
compiler.

Happens to me regularly.

-Andi
