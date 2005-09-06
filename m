Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVIFObj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVIFObj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 10:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVIFObi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 10:31:38 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:15292 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964873AbVIFObh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 10:31:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TKzUswuf6ytfB+nPV5nlzdKGFrGktA3Xq/cCQwN2ut81+mPzu5NpAOKb+Sz/KKA2C8zntoe08U43ExYPmf3EkdEM/vAwHIOsRy5PBWj+sh8cOtUZRNrsqOf1eeC5QiSuHhtVwAKilsFbpadocJ3B/VcYB+6B/SBeQCFm7vrUqAY=
Message-ID: <d120d50005090607315168e479@mail.gmail.com>
Date: Tue, 6 Sep 2005 09:31:34 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Daniel Phillips <phillips@istop.com>
Subject: Re: GFS, what's remainingh
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       Andi Kleen <ak@suse.de>, linux clustering <linux-cluster@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200509060318.25260.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050901104620.GA22482@redhat.com>
	 <200509060248.47433.phillips@istop.com>
	 <200509060155.04685.dtor_core@ameritech.net>
	 <200509060318.25260.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, Daniel Phillips <phillips@istop.com> wrote:
> On Tuesday 06 September 2005 02:55, Dmitry Torokhov wrote:
> > On Tuesday 06 September 2005 01:48, Daniel Phillips wrote:
> > > On Tuesday 06 September 2005 01:05, Dmitry Torokhov wrote:
> > > > do you think it is a bit premature to dismiss something even without
> > > > ever seeing the code?
> > >
> > > You told me you are using a dlm for a single-node application, is there
> > > anything more I need to know?
> >
> > I would still like to know why you consider it a "sin". On OpenVMS it is
> > fast, provides a way of cleaning up...
> 
> There is something hard about handling EPIPE?
> 

Just the fact that you want me to handle it ;)

> > and does not introduce single point
> > of failure as it is the case with a daemon. And if we ever want to spread
> > the load between 2 boxes we easily can do it.
> 
> But you said it runs on an aging Alpha, surely you do not intend to expand it
> to two aging Alphas?

You would be right if I was designing this right now. Now roll 10 - 12
years back and now I have a shiny new alpha. Would you criticize me
then for using a mechanism that allowed easily spread application
across several nodes with minimal changes if needed?

What you fail to realize that there applications that run and will
continue to run for a long time.

>  And what makes you think that socket-based
> synchronization keeps you from spreading out the load over multiple boxes?
> 
> > Why would I not want to use it?
> 
> It is not the right tool for the job from what you have told me.  You want to
> get a few bytes of information from one task to another?  Use a socket, as
> God intended.
>

Again, when TCPIP is not a native network stack, when libc socket
routines are not readily available - DLM starts looking much more
viable.

-- 
Dmitry
