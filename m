Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWFBO4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWFBO4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWFBO4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:56:36 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:9628 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751310AbWFBO4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:56:35 -0400
Date: Fri, 2 Jun 2006 10:56:26 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Preben Traerup <Preben.Trarup@ericsson.com>
Cc: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
Message-ID: <20060602145626.GB29610@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com> <20060530145658.GC6536@in.ibm.com> <20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com> <20060531154322.GA8475@in.ibm.com> <20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com> <20060601151605.GA7380@in.ibm.com> <20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com> <44800E1A.1080306@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44800E1A.1080306@ericsson.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 12:08:26PM +0200, Preben Traerup wrote:
> Akiyama, Nobuyuki wrote:
> 
> >
> >I don't think all people will use kdump(but I recommend my customer
> >to use kdump ;-).
> >The aim of panic notifier and crash notifier is a little different,
> >so I thought these notifier lists should be separated.
> >The panic notifier was not expected of kdump after notifier return!
> >I think the better way is to modify panic notifiers to fit with
> >kdump and to move into crash notifier gradually if necessary.
> >
> > 
> >
> Since I'm one of the people who very much would like best of both worlds,
> I do belive Vivek Goyal's concern about the reliability of kdump must be
> adressed properly.
> 
> I do belive the crash notifier should at least be a list of its own.
>  Attaching element to the list proves your are kdump aware - in theory
> 
> However:
> 
> Conceptually I do not like the princip of implementing crash notifier
> as a list simply because for all (our) practical usage there will only
> be one element attached to the list anyway.
> 
> And as I belive crash notifiers only will be used by a very limited
> number of users, I suggested in another mail that a simple
> 
> if (function pointer)
>   call functon
> 
> approach to be used for this special case to keep things very simple.

I think if we decide to implement something which allows other policies 
to co-exist with crash_kexec() then it should be more generic then a
single function pointer.

Thanks
Vivek
