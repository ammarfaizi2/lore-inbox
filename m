Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVDDQBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDDQBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 12:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDDQBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 12:01:42 -0400
Received: from alog0386.analogic.com ([208.224.222.162]:64968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261263AbVDDQBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 12:01:40 -0400
Date: Mon, 4 Apr 2005 12:00:34 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: David Vrabel <dvrabel@arcom.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: iomapping a big endian area
In-Reply-To: <42516034.7000802@arcom.com>
Message-ID: <Pine.LNX.4.61.0504041155530.4934@chaos.analogic.com>
References: <1112475134.5786.29.camel@mulgrave> 
 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk> 
 <20050402183805.20a0cf49.davem@davemloft.net> 
 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk> 
 <1112499639.5786.34.camel@mulgrave>  <20050402200858.37347bec.davem@davemloft.net>
  <1112502477.5786.38.camel@mulgrave>  <1112601039.26086.49.camel@gaston>
 <1112623143.5813.5.camel@mulgrave> <42516034.7000802@arcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, David Vrabel wrote:

> James Bottomley wrote:
>> so can you provide an example of a BE bus (or device) used on a LE
>> platform that would actually benefit from this abstraction?
>
> The Network Processing Engines in the Intel IXP425 are big-endian and
> its XScale core may be run in little-endian mode. There's a bunch of
> gotchas related to running in little-endian mode so you typically run
> the IXP425 in big-endian mode, though.
>

But the Linux interface (on the CPU side of the PCI bus interface)
doesn't care about the implimentation details in the XScale
Core. That's why it's a complete subsystem, isolated from the
ix86 by the PCI/Bus interface.

> David Vrabel
> -- 
> David Vrabel, Design Engineer
>
> Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
> Cambridge CB1 7EA, UK         Web: http://www.arcom.com/


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
