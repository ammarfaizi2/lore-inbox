Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319276AbSH2Rqj>; Thu, 29 Aug 2002 13:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319277AbSH2Rqj>; Thu, 29 Aug 2002 13:46:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7128 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S319276AbSH2Rqi>;
	Thu, 29 Aug 2002 13:46:38 -0400
Date: Thu, 29 Aug 2002 13:51:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andi Kleen <ak@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
In-Reply-To: <p737ki9shok.fsf@oldwotan.suse.de>
Message-ID: <Pine.GSO.4.21.0208291347540.15425-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 Aug 2002, Andi Kleen wrote:

> It does a better job for near all the string.h stuff. x86-64 just uses
> the builtins. Only exception  is memcpy, where it likes to call out of line 
> memcpy when it is not absolutely sure about all the alignments 
> (especally lots of casting causes that) 

memcpy() on x86 includes uses of mmx_memcpy().  Not likely to be done by gcc...

