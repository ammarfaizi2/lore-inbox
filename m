Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129844AbQK1L4j>; Tue, 28 Nov 2000 06:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129914AbQK1L43>; Tue, 28 Nov 2000 06:56:29 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:50185 "EHLO
        pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
        id <S129844AbQK1L4S>; Tue, 28 Nov 2000 06:56:18 -0500
Message-Id: <200011281125.eASBPaC13521@pincoya.inf.utfsm.cl>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Tue, 28 Nov 2000 01:28:36 BST." <20001128012836.B25166@athlon.random> 
Date: Tue, 28 Nov 2000 08:25:36 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> said:
> On Mon, Nov 27, 2000 at 02:34:45PM -0500, Richard B. Johnson wrote:
> > The following shell-script shows that gcc-2.8.1 produces code with
> > data allocations adjacent. However, they are reversed!

> same with 2.95.* :).

The point was if gcc did use the fact that variables are adyacent in memory
to generate better code, and this degenerated into the current discussion
about where they are from the programmers perspective.

- If gcc is going to use the fact that some variables are nearby for some
  optimization purposes, I do trust the gcc hackers to set stuff up so that
  they use it for variables that are nearby in VM, not just where defined
  together. If variables defined together end up adyacent or not is
  completely irrelevant. The compiler might even rearrange them to
  optimize for the access pattern observed.
- As a C programmer, you are only entitled to assume that pieces of the
  same object (array or struct) are laid out in memory in the order
  given. With segmented VM different objects would probably end up in
  different segments anyway.
--
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513  
  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
