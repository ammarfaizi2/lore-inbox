Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbVKHXdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbVKHXdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVKHXdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:33:54 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:56032 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030402AbVKHXdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:33:54 -0500
Subject: Re: typedefs and structs
From: Steven Rostedt <rostedt@goodmis.org>
To: linas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@austin.ibm.com,
       linuxppc64-dev@ozlabs.org
In-Reply-To: <20051108232327.GA19593@austin.ibm.com>
References: <20051105061114.GA27016@kroah.com>
	 <17262.37107.857718.184055@cargo.ozlabs.ibm.com>
	 <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com>
	 <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com>
	 <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com>
	 <20051107204136.GG19593@austin.ibm.com>
	 <1131412273.14381.142.camel@localhost.localdomain>
	 <20051108232327.GA19593@austin.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 08 Nov 2005 18:33:35 -0500
Message-Id: <1131492815.14381.184.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 17:23 -0600, linas wrote:
> On Mon, Nov 07, 2005 at 08:11:13PM -0500, Steven Rostedt was heard to remark:
> > On Mon, 2005-11-07 at 14:41 -0600, linas wrote:
> > 
> > don't use typedef to get rid of "struct".
> > 
> > This was for the simple reason, too many developers were passing
> > structures by value instead of by reference, just because they were
> > using a type that they didn't realize was a structure. 
> 
> That's a rather bizarre mistake to make, since, in order to 
> access a values in such a beast, you have to use a dot . instead 
> of an arrow -> and so it hits ou in the face that you passed a value
> instead of a reference.

It happens when you access the variable via macros and other routines
that you notice that takes and address of the variable, so you just pass
in the address of the current local variable.

> 
> ----
> Off-topic: There's actually a neat little trick in C++ that can 
> help avoid accidentally passing null pointers.  One can declare 
> function declarations as:
> 
>   int func (sturct blah &v) {
>     v.a ++; 
>     return v.b;
>   }
> 
> The ampersand says "pass argument by reference (so as to get arg passing
> efficiency) but force coder to write code as if they were passing by value"
> As a result, it gets difficult to pass null pointers (for reasons
> similar to the difficulty of passing null pointers in Java (and yes,
> I loathe Java, sorry to subject you to that))  Anyway, that's a C++ trick 
> only; I wish it was in C so I could experiment more and find out if I 
> like it or hate it.
> 

Actually, the true pass by reference (not by pointer) is one of the
things that C++ has, that I wish C had.

-- Steve


