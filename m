Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266443AbUGJV0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266443AbUGJV0P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbUGJV0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 17:26:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266443AbUGJV0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 17:26:04 -0400
To: Andi Kleen <ak@muc.de>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 and broken inlining.
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it>
	<2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it>
	<2fPfF-2Dv-19@gated-at.bofh.it>
	<m34qohrdel.fsf@averell.firstfloor.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 10 Jul 2004 18:25:52 -0300
In-Reply-To: <m34qohrdel.fsf@averell.firstfloor.org>
Message-ID: <orvfgvo8pr.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  9, 2004, Andi Kleen <ak@muc.de> wrote:

> Nigel Cunningham <ncunningham@linuxmail.org> writes:

> I think a better solution would be to apply the appended patch 

Agreed.  

> And then just mark the function you know needs to be inlined
> as __always_inline__.

It's probably a good idea to define such functions as `extern inline'
(another GCC extension), such that a definition of the function is
never emitted, and you get a linker error if the compiler somehow
fails to emit an error on a failure to inline the function.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
