Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVIHMYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVIHMYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVIHMYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:24:41 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:57101 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964867AbVIHMYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:24:40 -0400
Date: Thu, 8 Sep 2005 08:24:10 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: nazim khan <naz_taurus@yahoo.com>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org
Subject: Re: How to find out kernel stack over flow?
Message-ID: <20050908122410.GA17189@hmsreliant.homelinux.net>
References: <431EA245.2040703@stud.feec.vutbr.cz> <20050908051716.94223.qmail@web52601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908051716.94223.qmail@web52601.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 10:17:16PM -0700, nazim khan wrote:
> Thanks Michal for your response,
> 
> I forgot to mention that I am using linux 2.4.26,
> and STACKOVERFLOW option is not available here.
> 
> regards,
> Nazim
> 
It shouldn't be a difficult thing to hand-edit in (or at least an approximation
thereof).  Its really just a comparison of the current stack pointer in relation
to the current task_struct preformed in the do_IRQ function (so that it check
stack depth on interrupts).

Alternative to this method, or the netdump method I mentioned earlier.  If you
have some idea of which function(s) you are likely to be executing when the
stack overflows, you can also use -finstrument-functions as a finer grained
approach to detecting the problem.

Regards
Neil

> --- Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
> wrote:
> 
> > nazim khan wrote:
> > > I suspect that one of my module that I am
> > inserting in
> > > the kernel may be causing the stack overflow which
> > is
> > > leading to kernel crash (may because it is
> > corrupting
> > > some one lese memory).
> > > 
> > > How can I find this out?
> > 
> > You could enable CONFIG_DEBUG_STACKOVERFLOW.
> > If you showed us your module's source code, someone
> > might see the bug.
> > 
> > Michal
> > 
> 
> 
> 
> 	
> 		
> ______________________________________________________
> Click here to donate to the Hurricane Katrina relief effort.
> http://store.yahoo.com/redcross-donate3/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
