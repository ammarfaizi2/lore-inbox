Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSHZTaP>; Mon, 26 Aug 2002 15:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318287AbSHZTaP>; Mon, 26 Aug 2002 15:30:15 -0400
Received: from stargazer.compendium-tech.com ([64.156.208.76]:18692 "EHLO
	stargazer.compendium.us") by vger.kernel.org with ESMTP
	id <S318286AbSHZTaN>; Mon, 26 Aug 2002 15:30:13 -0400
Date: Mon, 26 Aug 2002 12:31:31 -0700 (PDT)
From: Kelsey Hudson <khudson@compendium.us>
X-X-Sender: khudson@betelgeuse.compendium-tech.com
To: "T. Ryan Halwachs" <halwachs@cats.ucsc.edu>
cc: kernel mailing list <linux-kernel@vger.kernel.org>,
       ataraid mailing list <ataraid-list@redhat.com>
Subject: Re: 3 x PDC20267 (ultra100) + software raid5 => kernel panic:
 Attempted to kill init!
In-Reply-To: <1030227978.2290.231.camel@p500m700>
Message-ID: <Pine.LNX.4.44.0208261224220.6621-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Aug 2002, T. Ryan Halwachs wrote:

> Hi all,
> hoping you can help me diagnose and correct some problems I am having
> with 3 promise ultra100 cards I am trying to use with 6 WD1200 drives to
> create an ide raid5 array.
> 
> I posted this to the ataraid list originally.
> https://listman.redhat.com/pipermail/ataraid-list/2002-August/001029.html
> 
> since then, using 2.4.19-ac4 I was able to successfully build a raid5
> array on 5 disks attached to 3 Promise ultra100 pci add-in cards
> (described in the original thread). I put some files on the array and
> they passed md5check. 
> I couldn't unmount the array. 
> I couldn't raidstop it.  
> When I restarted the machine, it intermittently would not talk to the
> drive on the third card. 

I tried basically the same setup here. It works, but on an older machine 
(read: not acpi controlled). Newer mainboards are fully ACPI controlled, 
and therefore use ACPI to configure and detect devices like hard disks, 
hard disk controllers, etc. For some reason, on some boards, devices on 
the fourth logical controller (onboard plus three devices) will not be 
seen. I've found no solution to this problem. All I can do is curse 
manufacturers for implementing ACPI.

This is the only thing I can come up with. 

My next step is to avoid software raid completely and drop some money on a 
3Ware hardware solution. It's more flexible anyways (and guaranteed to 
work). I'm not exactly happy with the Linux software raid (or really, any 
software raid at all). 

 Kelsey Hudson                                       khudson@compendium.us
 Software Engineer/UNIX Systems Administrator
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

