Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287681AbSAXMUp>; Thu, 24 Jan 2002 07:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287676AbSAXMUh>; Thu, 24 Jan 2002 07:20:37 -0500
Received: from gw.wmich.edu ([141.218.1.100]:60309 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S287657AbSAXMUU> convert rfc822-to-8bit;
	Thu, 24 Jan 2002 07:20:20 -0500
Subject: Re: amd athlon cooling on kt266/266a chipset
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0201241212250.7304-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201241212250.7304-100000@infcip10.uni-trier.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 07:19:09 -0500
Message-Id: <1011874755.22707.17.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-24 at 06:19, Daniel Nofftz wrote:
> On Thu, 24 Jan 2002, Norbert Preining wrote:
> 
> > Hi Daniel!
> >
> > You wrote:
> > > 2. enable generel-setup -> acpi , acpi-bus-maager , prozessor
> > >    in the kernel config
> >
> > Why is it necessary to activate acpi which makes apm not working,
> > and therefor poweroff etc. acpi is long from working/stable and
> > the support for various actions too are missing.
> >
> > >From the patch I do not see why it is specific to acpi?
> >
> > Best wishes
> 
> hi norbert!
> 
> ok ... i  tested it:
> patch activted:
> apm activated -> prozessor idle calls : 42°C when idle
> acpi activated -> prozessor c1/c2 states: 35°C when idle
> 
> under load:
> apm activated -> 47°C kernel compiling after 2 min
> acpi activated -> 43°C kernel compiling after 2 min
> 
> (kernel compiling only lasts about 3 min ... so no larger load intervalls
> are avaible at the moment ... )
> 
> so ... you could use apm ... but acpi proofs to be better in power saveing
> with the "disconnectenable when STPGNT detected" bit set ...
> maybe apm is not working at all .. .cause at the moment i see that the
> temperature does not drop at all after finishing the kernel ... it looks
> like that the 42°C only where cause it was fresh rebooted from the acpi
> power saving mode

You should check your /var/log/messages directly for this nifty little
message. 
kernel: ACPI: APM is already active, exiting

If you compiled in apm at the time you did that test,  acpi wasn't even
active and thus the special athlon disconnect patch wasn't even
working.   So all of that better cooling would be psychoschomatic.  
Wouldn't be the first time better cooling/performance was all in the
head of the person using the hardware...although if you didn't have apm
compiled in then none of this matters and it was all working. But i
doubt that is true due to the 42C idle after some use no matter which
kernel was being used.  


Furthermore, I haven't heard of anyone where the patch actually makes an
improvement in temp with the patch.  But i have heard of people saying
it affected performance detrimentally. If it is helping and the cpu fans
decrease due to the lower temp, add fan speeds in different loads/temps
to reflect this.  
lowering the fan speed and thus noise is more than a welcome change.    


