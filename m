Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbTDQIe4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 04:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTDQIe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 04:34:56 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:5829 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261258AbTDQIez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 04:34:55 -0400
Date: Thu, 17 Apr 2003 04:43:23 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Problem: 2.4.20, 2.5.66 have different IDE channel order
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304170446_MC3-1-34CA-A41@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:


>>    2.5 nonmodular seems to be doing it in BIOS order  -- the HPT370 BIOS
>>  initializes before the Promise (and won't let it boot but I can deal
>>  with that.)  I'll probably replace it with a PDC20262 before looking
>
> Im a bit puzzled by this because it does look like a bug. Our pci
> scan code hasnt changed that materially. I assume the promise and
> hpt are both plug in cards >


  Tried PDC20268 + 20262 and the IDE channel order is still rearranged
in 2.5 even though the BIOSen now initialize in bus order (it can
boot from hd again.)

  Why it goes from (1,2,3) in 2.4 to (1,3,2) in 2.5 is still a mystery.
I could see it reversing, but not this.

  Tried 2.5.66-ac1 with no APIC support and IDE was still backwards.
It also spewed continuous keyboard errors until I hit reset:


   atkbd.c: Unknown key (set 0, scancode 0xfc, on isa0060/serio1) pressed.



--
 Chuck
