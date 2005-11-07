Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965300AbVKGUll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300AbVKGUll (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbVKGUll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:41:41 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:3016 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965300AbVKGUlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:41:39 -0500
Date: Mon, 7 Nov 2005 14:41:36 -0600
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: typedefs and structs [was Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks]
Message-ID: <20051107204136.GG19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com> <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107200257.GA22524@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 12:02:57PM -0800, Greg KH was heard to remark:
> On Mon, Nov 07, 2005 at 01:36:00PM -0600, linas wrote:
> > On Mon, Nov 07, 2005 at 11:02:45AM -0800, Greg KH was heard to remark:
> > > 
> > > No, never typedef a struct.  That's just wrong.  
> > 
> > Its a defacto convention for most C-language apps, see, for 
> > example Xlib, gtk and gnome.
> 
> The kernel is not those projects.

!!

> > Also, "grep typedef include/linux/*" shows that many kernel device
> > drivers use this convention.
> 
> They are wrong and should be fixed.

What, precisely, is wrong?

> See my old OLS paper on all about the problems of using typedefs in
> kernel code.

Is this on the web somewhere? Google is having trouble finding it.

I understand that old code bases often choke on typedefs;
forward declarations are a big problem. Not to be rude, 
but choking for forward decl's is often a symptom of 
poorly-designed code.

> > > gcc should warn you
> > > just the same if you pass the wrong struct pointer 
> > 
> > There were many cases where it did not warn (I don't remember 
> > the case of subr calls). I beleive this had to do with ANSI-C spec
> > issues dating to the 1990's; traditional C is weakly typed.
> > 
> > Its not just gcc; anyoe who coded for a while eventually discovered
> > that tyedefs where strongly typed, but "struct blah *" were not.
> 
> Sorry, but you are using a broken compiler if it doesn't complain about
> this.

Uhh, gcc? 

Maybe I've just got more mileage under my wheels. Of all of the 
compilers I've used, gcc has always had the strictest checking, 
and was the most verbose about warnings.  There's a trick that pros
use when they inherit crufty old code: run it through gcc first, and
clean it up, even if the project requires using some other compiler.

I was simply stating a fact about gcc and about standard ANSI-C 
type-checking that is "well known" to anyone who's been around the 
block. I was not trying to start an argument.

--linas

