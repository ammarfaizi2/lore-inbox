Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275857AbRJMNsb>; Sat, 13 Oct 2001 09:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278291AbRJMNsV>; Sat, 13 Oct 2001 09:48:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63748 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275857AbRJMNsO>; Sat, 13 Oct 2001 09:48:14 -0400
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 13 Oct 2001 14:54:25 +0100 (BST)
Cc: paulus@samba.org (Paul Mackerras), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110121846030.8148-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 12, 2001 07:00:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15sPFB-0002jT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is discussed in the multi-procesor management section, under "memory
> ordering", and it does say that "reads can be carried out specilatively
> and in any order".
> 
> HOWEVER, it does have what Intel calles "processor order", and it claims
> that "writes by a single processor are observed in the same order by all
> processors."

The other thing on the intel side is that you have to read the errata
documentation. There are an interesting collection of misordering errata.

> (But Intel has redefined the memory ordering so many times that they might
> redefine it in the future too and say that dependent loads are ok. I
> suspect most of the definitions are of the type "Oh, it used to be ok in
> the implementation even though it wasn't defined, and it turns out that
> Windows doesn't work if we change it, so we'll define darkness to be the
> new standard"..)

Its notable that the folks who did looser ordering x86 clones had MTRRs
to enable the performance boost

Alan
