Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273124AbRIOXsK>; Sat, 15 Sep 2001 19:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273123AbRIOXsA>; Sat, 15 Sep 2001 19:48:00 -0400
Received: from mailsrv.rollanet.org ([192.55.114.7]:41747 "HELO
	mx.rollanet.org") by vger.kernel.org with SMTP id <S273124AbRIOXrq>;
	Sat, 15 Sep 2001 19:47:46 -0400
Message-ID: <3BA3E8B9.2DAA117@umr.edu>
Date: Sat, 15 Sep 2001 18:48:09 -0500
From: Nathan Neulinger <nneul@umr.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Johnson <dave-kernel-list2@centerclick.org>
CC: linux-kernel@vger.kernel.org, uetrecht@umr.edu
Subject: Re: Problems with 3ware error event notification in kernel
In-Reply-To: <F349BC4F5799D411ACE100D0B706B3BB7690AE@umr-mail03.cc.umr.edu> <v04210100b7c9939ad124@[10.0.2.30]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Johnson wrote:
> 
> On 8/15/01, Neulinger, Nathan wrote:
> >I've got a situation with the 3ware driver and 3dm monitor where it appears
> >to stop receiving notification of status changes from the kernel.
> >
> >I've seen this with 2.2.19+variouspatches and 2.4.7-ac3. (On some other
> >machines, it appears to work fine.)
> >
> >Basically, all of the real-time monitoring and instantaneous status request,
> >as well as configuration change, etc. stuff all works fine, but after a
> >while, the 3dm monitor no longer gets messages talking about drive failure
> >(pulling a drive on hot-swap tray) or when the rebuilds start/stop. Even
> >restarting the 3dm monitor doesn't seem to help this.
> 
> I've noticed this problem several times.  It's not just the email
> notification.  The 'alarms' section of 3dm as well as the syslog
> entries just stop happening.
> 
> >Strace doesn't seem to work on the 3dm executable since it's threaded... (Is
> >there a way to get that to work?)
> 
> Have you tried '-f -F' ?  I haven't tried it since my controller is
> on a production system.

Yeah, it seems like the threads are causing an issue. Even attaching to
an existing process fails.

> On another note something (I assume 3dm) loves to look for eth
> interfaces just prior to every event:
> 
> Sep  4 15:30:20 alliance modprobe: modprobe: Can't locate module eth3
> Sep  4 15:30:20 alliance modprobe: modprobe: Can't locate module eth1
> Sep  4 15:30:20 alliance 3w-xxxx[874]: Drive error encountered on
> port 2 on controller ID:1. Check cables and drives for media errors.
> (0xa)
> 
> somewhat annoying, and very unnerving as it shouldn't be do anything
> with the networking setup.  Anyone else seen this?

Hmm.. haven't seen that... a bit odd though. Perhaps your modules.conf
has something in it causing the probes when 3dm tries to do mail send or
something?

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
CIS - Systems Programming                Fax: (573) 341-4216
