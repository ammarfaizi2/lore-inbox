Return-Path: <linux-kernel-owner+w=401wt.eu-S964832AbWLTDTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWLTDTk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 22:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWLTDTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 22:19:40 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:31613 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964832AbWLTDTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 22:19:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=BctSqHlvrdcgFBuvhZ61KXbug83B1RQKtK5JCBdMxIRCnwE976KExFOnmrNp2Nii20mTI/R6J5u73YQkFUDw2HeqFWUY+LMnsLlWO3JszlF+vMS0ff1fZdWtaBI2+sBRHu9zmK0W4atBBVOSKZwuYt1HaZi2LA/MSHUZ8Nqi8c8=  ;
X-YMail-OSG: DenAamwVM1lHmURTliHNip4iwLzBZmGe5dmOERD2XDwdevE__Ynx4mW6k5CGNzhUbPTLPelmIe16YfS54ExhTbJC1ZoDjdAwWVPXkDuq.YGdpFV.t1d_XqB8NWzJTN4mM.kTupsYj9Ot_0R1_LQGMbFFZYHafElU8jBOJ.krnBkkIzUHs1w_Vps4562W
From: David Brownell <david-b@pacbell.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Changes to PM layer break userspace
Date: Tue, 19 Dec 2006 19:19:36 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612191536.28998.david-b@pacbell.net> <20061220000955.GA17231@srcf.ucam.org>
In-Reply-To: <20061220000955.GA17231@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612191919.36813.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 4:09 pm, Matthew Garrett wrote:
> On Tue, Dec 19, 2006 at 03:36:28PM -0800, David Brownell wrote:
> > On Tuesday 19 December 2006 2:57 pm, Matthew Garrett wrote:
> > > The fact that something is scheduled to be removed in July 2007 does 
> > > *not* mean it's acceptable to break it in 2006. We need to find a way to 
> > > fix this functionality in the meantime.
> > 
> > The disconnect here is analagous to:  I tell you the alleged perpetual
> > motion machine never worked, and can't ever work; and you push back and
> > say that you need a perpetual motion machine that works, NOW please,
> > because you need something that pushes those widgets around.  (There are
> > better ways to push widgets than side effects of a broken machine...)
> 
> But it *did* work. 

Having been on the other side ... I can testify that if you
think it actually worked, it's because you're ignoring all
the nasty failure modes.


> > I'd not be keen on reverting Linus' patch [1] myself, even though few
> > drivers have started to use that mechanism yet; that would be a step
> > backwards, and would perpetuate users of that broken sysfs file.
> 
> I'm sorry, which bit of "Don't break userspace API without adequate 
> prior warning and with a workable replacement" is difficult to 
> understand?

What part of "it was already broken" do YOU not understand?  The
whole notion is unsustainable.  It doesn't work cross-platform, or
for multiple bus types.  It confuses system-wide suspend mechanisms
with runtime mechanisms.  It breaks guaranteed parent/child ordering
of suspend/resume calls.  (And more...)


Let us know when you get tired of whining and want to move on to
getting a real solution to the set of problems here.  I've pointed
out that reverting Linus' patch would be one option to get your
short term issue rsolved ... that would remove a capability from
PCI drivers, but you could then use that deprecated mechanism.
I've also pointed out that you could start working towards a real
long term solution.

Do you have an alternate solution?

- Dave

