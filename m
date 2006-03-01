Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWCAO4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWCAO4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWCAO4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:56:19 -0500
Received: from cantor.suse.de ([195.135.220.2]:2438 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932272AbWCAO4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:56:18 -0500
From: Andi Kleen <ak@suse.de>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Subject: Re: AMD64 X2 lost ticks on PM timer
Date: Wed, 1 Mar 2006 15:56:09 +0100
User-Agent: KMail/1.9.1
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
References: <200602280022.40769.darkray@ic3man.com> <p73veuzyr8p.fsf@verdi.suse.de> <20060301144641.GB20092@ti64.telemetry-investments.com>
In-Reply-To: <20060301144641.GB20092@ti64.telemetry-investments.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011556.10139.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 15:46, Bill Rugolsky Jr. wrote:
> On Wed, Mar 01, 2006 at 12:53:58AM +0100, Andi Kleen wrote:
> > What chipset?
> 
> Thanks for the interest, Andi.
>  
> The chipset is NVIDIA nForce Pro 2200 (CK804).  The mobo is Tyan 2895:

I have such a system sitting next to me and it doesn't show any such symptoms.
I normally don't let it run unrebooted over days though.

I would suspect some driver.
Do you use any special addin cards? What modules are you using?

>   http://www.tyan.com/products/html/thunderk8we.html
> 
> It's running the current 1.02 version of the BIOS.

My BIOS is

 Version: 2004Q3
 Release Date: 06/07/2005

(which is self contradicting, but oh well) 


> Current kernel is the FC4 errata:

I don't run these kernels though - only mainline.

> 1141220165:151240: rtc 464 int 0 125 (=125)
...

Looks all ok. Your timer interrupts are ticking correctly.

> time.c: Lost 3 timer tick(s)! rip poll_idle+0x14/0x19)

Ok then it's not C1.

-Andi
