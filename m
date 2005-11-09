Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbVKIAnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbVKIAnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVKIAnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:43:00 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:41416 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932391AbVKIAnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:43:00 -0500
Date: Tue, 8 Nov 2005 18:42:47 -0600
To: Zan Lynx <zlynx@acm.org>
Cc: David Gibson <dwg@au1.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
Subject: Re: typedefs and structs
Message-ID: <20051109004247.GL19593@austin.ibm.com>
References: <20051107182727.GD18861@kroah.com> <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com> <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com> <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com> <20051108235759.GA28271@localhost.localdomain> <1131495228.12797.67.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131495228.12797.67.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 05:13:48PM -0700, Zan Lynx was heard to remark:
> On Wed, 2005-11-09 at 10:57 +1100, David Gibson wrote:
> > 
> > I hate it: it obscures the fact that it's a pass-by-reference at the
> > callsite, which is useful information.  Although this is, admittedly,
> > the least confusing use of C++ reference types.
> 
> I agree with you about that one.  It's yet another thing for C
> programmers to have to learn to watch for C++ doing behind your back.

I think you're rushing to judgement on something you've never tried. 
It fundamentally changes coding style; you'd have to try it on some 
mid-size project for at least a few months or longer to get into the
mindset.  To make it all work, you also have to do other things, like 
avoid mallocs and allocing on stack, which forces major changes of 
style (because of the lifetime of things on stack). If you don't change 
style to go with it, then you'll just end up in debug hell, in which
case you'd be right: it would be a (very) bad idea.

(Disclaimer: I've moved away from C++ because of all the other
opportunities for misuse that it offers and encourages.)

--linas


