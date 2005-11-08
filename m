Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVKHXXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVKHXXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbVKHXXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:23:42 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:39107 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964940AbVKHXXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:23:41 -0500
Date: Tue, 8 Nov 2005 17:23:27 -0600
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@austin.ibm.com,
       linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs 
Message-ID: <20051108232327.GA19593@austin.ibm.com>
References: <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com> <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com> <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131412273.14381.142.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 08:11:13PM -0500, Steven Rostedt was heard to remark:
> On Mon, 2005-11-07 at 14:41 -0600, linas wrote:
> 
> don't use typedef to get rid of "struct".
> 
> This was for the simple reason, too many developers were passing
> structures by value instead of by reference, just because they were
> using a type that they didn't realize was a structure. 

That's a rather bizarre mistake to make, since, in order to 
access a values in such a beast, you have to use a dot . instead 
of an arrow -> and so it hits ou in the face that you passed a value
instead of a reference.

----
Off-topic: There's actually a neat little trick in C++ that can 
help avoid accidentally passing null pointers.  One can declare 
function declarations as:

  int func (sturct blah &v) {
    v.a ++; 
    return v.b;
  }

The ampersand says "pass argument by reference (so as to get arg passing
efficiency) but force coder to write code as if they were passing by value"
As a result, it gets difficult to pass null pointers (for reasons
similar to the difficulty of passing null pointers in Java (and yes,
I loathe Java, sorry to subject you to that))  Anyway, that's a C++ trick 
only; I wish it was in C so I could experiment more and find out if I 
like it or hate it.

--linas
