Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWBJNBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWBJNBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWBJNBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:01:00 -0500
Received: from smtp.enter.net ([216.193.128.24]:268 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751257AbWBJNA7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:00:59 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Thu, 9 Feb 2006 07:57:12 -0500
User-Agent: KMail/1.8.1
Cc: matthias.andree@gmx.de, peter.read@gmail.com, mj@ucw.cz,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner>
In-Reply-To: <43EC887B.nailISDGC9CP5@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602090757.13767.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 07:35, Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> > > > Nonsense. The b,t,l addresses are NOT stable (at least for transports
> > >
> > > Dou you like to verify that you have no clue on SCSI?
> >
> > How does, for instance, libscg make sure that the b,t,l mappings are
> > hotplug invariant?
> >
> > How does libscg make sure that two external writers, say USB, retain
> > their b,t,l mappings if both are unplugged and then replugged in reverse
> > order, perhaps into different USB hubs?
>
> Well, this is a deficit of the Linux kernel - not libscg.
>
> If you are unhappy with Hot plug support on Linux, I recommend you to
> check Solaris.
>
> Jörg

I've replied once already, but this is going to far. Joerg, if you are so 
unhappy with Linux that you'd actively tell people on the _LINUX_KERNEL_ 
mailing list to go use another OS then you have a problem.

If, however, you have a point to make, make it. I switched to Linux 
_completely_ before it even supported the box I was running fully back around 
kernel 2.0.24 and had run it alongside windows since late in Kernel 1 series. 
The system has evolved, gotten faster, better and more standards compliant. 
Then you come along with this teutonic "I'm the Perfect Programmer" BS and 
expect everyone to change the way something works just for _your_ library.
I'm sorry but that is, and I'm being nice here, childish. Programs and 
libraries *_DO_* *_NOT_* define how an OS does things, they use the framework 
the OS supplies and work within it. With that in mind I'll say the last thing 
I ever will on this subject - Your code is broken if it does things in a way 
that is non-standard to the OS.

And does cdrecord even need libscg anymore? From having actually gone through 
your code, Joerg, I can tell you that it does serve a larger purpose. But at 
this point I have to ask - besides cdrecord and a few other _COMPACT_ _DISC_ 
writing programs, does _ANYONE_ use libscg? Is it ever used to access any 
other devices that are either SCSI or use a SCSI command protocol (like 
ATAPI)?  My point there is that you have a wonderful library, but despite 
your wishes, there is no proof that it is ever used for anything except 
writing/ripping CD's.

If anything, the best solution would be to split libscg away from the cdrtools 
package and release it on it's own. You do that and it might even make the 
SANE people happy. All the cdrtools package needs is an interface library for 
CDR/RW stuff and having the code capable of doing anything else is merely 
bloat.

DRH
