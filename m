Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRKVMDu>; Thu, 22 Nov 2001 07:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277564AbRKVMDk>; Thu, 22 Nov 2001 07:03:40 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40129 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277541AbRKVMDa>;
	Thu, 22 Nov 2001 07:03:30 -0500
Date: Thu, 22 Nov 2001 07:03:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Stevie O <stevie@qrpff.net>, Vincent Sweeney <v.sweeney@dexterus.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {} 
In-Reply-To: <200111221146.fAMBk8XF006908@pincoya.inf.utfsm.cl>
Message-ID: <Pine.GSO.4.21.0111220655040.29272-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Nov 2001, Horst von Brand wrote:

> Stevie O <stevie@qrpff.net> said:

> > But x++ is postincrement though. That means the value of 'x' is inserted, 
> > and after the expression is evaluated, x is incremented. Right?
> 
> Nope. x++ increments x sometime (not defined when) after taking the value. 
> 
>    x = x++ % y
> 
> is wrong: There is just one sequence point at the end of the expression,
> and x is modified twice in between (++ and =).

Or look at it that way: both
	tmp = x % y; x++; x = tmp;
and
	tmp = x % y; x = tmp; x++;
are possible interpretations with different results.  And as usual, compiler
is allowed to do literally anything whenever it sees such beast.

