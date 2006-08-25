Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422720AbWHYPZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbWHYPZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWHYPZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:25:06 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:656 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422716AbWHYPZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:25:03 -0400
Date: Fri, 25 Aug 2006 11:24:28 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: kmannth@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       andrew <akpm@osdl.org>
Subject: Re: [Bug] 2.6.18-rc4-mm2 panic in __unix_insert_socket x86_64
Message-ID: <20060825152428.GB8909@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1156293593.11365.12.camel@keithlap> <1156472449.5913.38.camel@keithlap> <200608250829.46066.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608250829.46066.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 08:29:46AM +0200, Andi Kleen wrote:
> On Friday 25 August 2006 04:20, keith mannthey wrote:
> > On Tue, 2006-08-22 at 17:39 -0700, keith mannthey wrote:
> > > Hello all,
> > >   Something from mm1 to mm2 brought this bug out. I didn't see any
> > > change in the unix socket code so I am not sure where to start. I am
> > > going to start bisecting patches. 2.6.18-rc4-mm1 was working as
> > > expected.  I have already stepped around afs and smp alternatives errors
> > > but I haven't seen any errors related to this posted yet.
> > 
> > 
> > Ok finally finished all the rebuilds/reboots needed find the trouble
> > patch.  What seems to be causing the problem is listed as 
> > 
> > Re-positioning the bss segment   or 
> > x86_64-mm-re-positioning-the-bss-segment.patch
> > 
> > It seems something is getting trampled.  Thoughts?
> 
> Hmm, it seems to be outside _edata now. There are a couple of references,
> but I'm not sure they actually matter
> 

It was outside _edata even before. So that should not make any difference.
It boots fine on my machine. Strange. I am looking into it.

Thanks
Vivek

