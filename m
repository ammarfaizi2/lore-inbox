Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVBJVVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVBJVVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 16:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVBJVVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 16:21:13 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:935 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S261290AbVBJVVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 16:21:09 -0500
Message-ID: <420BD03A.3030501@scitechsoft.com>
Date: Thu, 10 Feb 2005 13:20:58 -0800
From: Kendall Bennett <kendallb@scitechsoft.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Jon Smirl <jonsmirl@gmail.com>,
       =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>,
       Bill Davidsen <davidsen@tmr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <1107695583.14847.167.camel@localhost.localdomain>	 <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi>	 <1108066096.4085.69.camel@tyrosine>	 <9e473391050210121756874a84@mail.gmail.com>	 <1108067388.4085.74.camel@tyrosine>	 <9e47339105021012341c94c441@mail.gmail.com>	 <420BC814.4050102@scitechsoft.com> <1108069596.4085.78.camel@tyrosine>
In-Reply-To: <1108069596.4085.78.camel@tyrosine>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett said the following on 2/10/2005 1:06 PM:
> On Thu, 2005-02-10 at 12:46 -0800, Kendall Bennett wrote:
> 
> 
>>So perhaps this problem is something similar?
> 
> 
> I don't think so - if I dd out of ROM, I get something that looks like a
> video BIOS (and, indeed, I can make VBE calls to and from it). The
> problem is jumping to c000:0003 and executing - this has the effect of
> turning off the backlight and giving an illegal instruction error
> (I /think/ - I may be getting the machine I have here confused with one
> a tester has...)

Laptops are a little different as they will make calls from the Video 
BIOS into the system BIOS, so you need to make sure that the system BIOS 
is also available in the execution environment. So if you are using an 
x86 emulator, you need to make sure the system BIOS is mapped into the 
emulator image and that any necessary resources it might need are available.

Regards,

-- 
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

