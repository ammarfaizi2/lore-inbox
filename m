Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVBJS6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVBJS6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVBJS6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:58:45 -0500
Received: from mail.tmr.com ([216.238.38.203]:2443 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261290AbVBJS56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:57:58 -0500
Message-ID: <420BB267.8060108@tmr.com>
Date: Thu, 10 Feb 2005 14:13:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pavel Machek <pavel@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]   Samsung
 P35, S3, black screen (radeon))
References: <20050205093550.GC1158@elf.ucw.cz><e796392205020221387d4d8562@mail.gmail.com> <1107695583.14847.167.camel@localhost.localdomain>
In-Reply-To: <1107695583.14847.167.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sad, 2005-02-05 at 09:35, Pavel Machek wrote:
> 
>>Rumors say that notebooks no longer have video bios at C000h:0; rumors
>>say that video BIOS on notebooks is simply integrated into main system
>>BIOS. I personaly do not know if rumors are true, but PCs are ugly
>>machines....
>>							
> 
> 
> A small number of laptop systems are known to pull this trick. There are
> other problems too - the video bios boot may make other assumptions
> about access to PCI space, configuration, interrupts, timers etc.
> 
> Some systems (intel notably) appear to expect you to use the bios
> save/restore video state not re-POST.

Isn't that what it's there for? In any context other than save/restore I 
wouldn't think using the BIOS was a good approach. But this is a special 
case, and if there's a BIOS function which does the right thing, it 
would seem to be easier to assume that the BIOS works than that the 
driver can do every operation for a clean restart.

The problem is that while POST leaves the video in a known state, it may 
not the known state you want, nor is it a given that you can get from 
there to where you were on suspend. PC hardware isn't always that 
dependable.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
