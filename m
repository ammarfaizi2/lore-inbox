Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWIUTuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWIUTuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWIUTuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:50:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37791 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751489AbWIUTuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:50:44 -0400
Date: Thu, 21 Sep 2006 15:50:24 -0400
From: Dave Jones <davej@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>,
       Robin Getz <rgetz@blackfin.uclinux.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: drivers/char/random.c exported interfaces
Message-ID: <20060921195024.GI17065@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Torokhov <dtor@insightbb.com>,
	Robin Getz <rgetz@blackfin.uclinux.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
	Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
References: <6.1.1.1.0.20060920125855.01eca0c0@ptg1.spd.analog.com> <200609210011.25891.dtor@insightbb.com> <20060921191551.GC17065@redhat.com> <d120d5000609211238t1fb38d4exaa5c107a55a9eac3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000609211238t1fb38d4exaa5c107a55a9eac3@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 03:38:56PM -0400, Dmitry Torokhov wrote:

 > > Under what circumstances is it desirable to allow INPUT=m ?
 > > I'm having a hard time thinking of a usage scenario where it makes sense.
 > 
 > Not normally, no. But for example NSLU2 has a beeper and I believe it
 > is the only user of input core there. If you were doing a distribution
 > for such device you might want to build both input core and speaker
 > driver as modules and let user decide if he wants to thoad them or
 > not.

Wow. That's a ton of code to be pulling in just to enable a beeper.
I wonder how many lines a non-input-layer variant of pcspkr.c would be.
It always seemed odd to me that a beeper is an input device anyway.

 > Does it being a module hurt anything?

Addition of two more exports for an arguably questionable purpose.

	Dave
