Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRDGSgd>; Sat, 7 Apr 2001 14:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRDGSgW>; Sat, 7 Apr 2001 14:36:22 -0400
Received: from panchito.Austria.EU.net ([193.154.160.103]:26795 "EHLO
	relay3.austria.eu.net") by vger.kernel.org with ESMTP
	id <S129292AbRDGSgL>; Sat, 7 Apr 2001 14:36:11 -0400
Message-ID: <3ACF5E15.2A6E4F3C@eunet.at>
Date: Sat, 07 Apr 2001 20:36:05 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>
CC: Tim Waugh <twaugh@redhat.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <Pine.LNX.4.10.10104071507230.1561-100000@linux.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> 
> > Tim Waugh wrote:
> > > > Adding PCI entries to both serial.c and parport_pc.c was that easy....
> > >
> > > And that's how it should be, IMHO.  There needs to be provision for
> > > more than one driver to be able to talk to any given PCI device.
> >
> > True, true, true.
> 
> Could you start up your brain now :) 
There's no need to start it. My brain is either 'always on', or
'suspended to ram' :-)

> and think about the actual issue. All
> the drivers must share the device resources and there is no (simple) way
> to do so generically.
> What you want to do is to write a single software driver, optionnaly
> broken into several modules, that is aware of all the functionnalities of
> the board and that will register to all involved sub-systems as needed.

I agree. that would be the clean solution. Jeff Grazik provided some
sample code, I'll try to write a driver according to this. If I find the
time....

But what I want to know before I spend time (and not-earning-money :-)
into this, I want to know: Is this the right way (TM)? How do other
multiport cards deal with this issue?

This is a specific question to the serial and parallel maintainers: are
there cards supported by _both_ the serial and parallel subsystem? Do
they work with 2.4.3? Will they work in the future? (I'm too lazy to
compare the PCI tables from serial and parallel ;-)

Another (design) question: How will such a driver/module deal with
autodetection and/or devfs? I don't like to specify 'alias /dev/tts/4
netmos', because thats pure junk to me. What about pci hotplugging?

(keep in mind that I'm new to kernel development)


> What about the option of using a different hardware ? :-)

Har har har. Could you please tell me where to get one? I don't know how
it's in your country, but here in austria you can call yourself a lucky
guy if you even find a PCI serial/parallel card. If you find one, you'll
find _one_. It's packaged in a little box where it reads "PCI 2S/1P
board". The 'manual' is a bit larger than a stamp. 

I could buy one after another, and try if they have a well-designed PCI
interface. 

I don't have the time for this.

I agree with you that this kind of hardware is junk. But there's a lack
of alternatives....

If there's a reasonable number of 'good' hardware out there, I'll forget
about Netmos and buy me a new card. If not, I'm willing to provide a
driver. 


bye, Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
