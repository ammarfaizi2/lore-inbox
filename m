Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291600AbSBHPOn>; Fri, 8 Feb 2002 10:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291604AbSBHPOh>; Fri, 8 Feb 2002 10:14:37 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:27921 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S291600AbSBHPNw>;
	Fri, 8 Feb 2002 10:13:52 -0500
Date: Fri, 8 Feb 2002 08:13:00 -0700
From: yodaiken@fsmlabs.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: yodaiken@fsmlabs.com, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel@vger.kernel.org, akpm@zip.com.au, mingo@elte.hu,
        rml@tech9.net, nigel@nrg.org
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020208081300.A5768@hq.fsmlabs.com>
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <20020207125601.A21354@hq.fsmlabs.com> <200202080847.g188lMt13875@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200202080847.g188lMt13875@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Fri, Feb 08, 2002 at 10:47:24AM -0200
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 10:47:24AM -0200, Denis Vlasenko wrote:
> On 7 February 2002 17:56, yodaiken@fsmlabs.com wrote:
> > > If a spin_lock request is blocked by a mutex_lock call, the spin_lock
> > > attempt also sleeps i.e. behaves like a semaphore.
> >
> > So what's the difference between combi_spin and combi_mutex?
> > combi_spin becomes
> > 	if not mutex locked, spin
> > 	else sleep
> > Bizzare
> 
> combi_spin_lock():
> If not mutex locked, spin - will be released shortly
> else sleep - may take long time before released
>  * lock released *
> spin lock it!     <=== this is the difference -
>                        combi_mutex_lock would mutex lock it here
> 
> What's wrong with this?

In the elegant words of Andrew Morton, this is a "I don't know what
the fuck I'm doing lock".


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

