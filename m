Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261714AbTCGSfw>; Fri, 7 Mar 2003 13:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261715AbTCGSfw>; Fri, 7 Mar 2003 13:35:52 -0500
Received: from mail.tbdnetworks.com ([63.209.25.99]:56788 "EHLO
	tbdnetworks.com") by vger.kernel.org with ESMTP id <S261714AbTCGSfv>;
	Fri, 7 Mar 2003 13:35:51 -0500
Subject: Re: [PATCH] Multiple & vs. && and | vs. || bugs in 2.4.20
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030306195812.GH2781@zaurus.ucw.cz>
References: <20030302121425.GA27040@defiant> <3E6247F7.8060301@redhat.com>
	 <20030306195812.GH2781@zaurus.ucw.cz>
Content-Type: text/plain
Organization: TBD Networks
Message-Id: <1047062752.30853.135.camel@defiant>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Mar 2003 10:45:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan included my 2.4.20 patches - including the one for acm.c - in
2.4.21-pre5-ac1, so I expect them to show up in mainline someday.  Still
working on delivering some of the 2.5.x ones...

--nk

On Thu, 2003-03-06 at 11:58, Pavel Machek wrote:
> Hi!
> 
> > >  
> > > -	if (!urb->status & !acm->throttle)  {
> > > +	if (!urb->status && !acm->throttle)  {
> > >  		for (i = 0; i < urb->actual_length && !acm->throttle; i++) {
> 
> > To summarize, I'd probably not be amused if you would change any of my
> > code which takes advantage of such programming finess.  I would probably
> > have added appropriate comments to explain the code but nevertheless,
> > replacing the more efficient code with some which is easier to
> > understand should probably be considered on a case by case basis.
> 
> Actually I feel co-responsible for acm.c,
> and this *is* typo. acm is for modems,
> thats *not* performance critical, and certainly
> not worth code obfuscation.
-- 
Norbert Kiesel <nkiesel@tbdnetworks.com>
TBD Networks

