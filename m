Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVADFtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVADFtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVADFtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:49:17 -0500
Received: from mx.freeshell.org ([192.94.73.21]:62691 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261543AbVADFtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 00:49:10 -0500
Date: Tue, 4 Jan 2005 05:49:07 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <d120d50005010308355783c996@mail.gmail.com>
Message-ID: <Pine.NEB.4.61.0501040543490.25801@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> 
 <200501022206.50265.dtor_core@ameritech.net>  <Pine.NEB.4.61.0501030536110.14662@sdf.lonestar.org>
  <200501030123.58884.dtor_core@ameritech.net>  <Pine.NEB.4.61.0501031317110.15363@sdf.lonestar.org>
 <d120d50005010308355783c996@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

I have tried kernels 2.6.9-rc2-bk3 and 2.6.9-rc2-bk4. I first copied the 
.config from the stripped-down 2.6.10 into the 2.6.9- directories and then 
ran make oldconfig (hopefully make oldconfig works in reverse?).  Then I 
built and ran the kernels. Both exhibit the same behavior as 2.6.10 
regarding the keyboard.

The /var/log/{dmesg,syslog,messages,kern.log} files for both kernels are 
available at:

  http://roey.freeshell.org/mystuff/kernel/


- Roey

PS:  I forgot the log_buf_len=131072, hope it's ok for you...
PPS: I also forgot "acpi=off".  Should I re-run these tests?



On Mon, 3 Jan 2005, Dmitry Torokhov wrote:

> Date: Mon, 3 Jan 2005 11:35:25 -0500
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reply-To: dtor_core@ameritech.net
> To: Roey Katz <roey@sdf.lonestar.org>
> Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
> Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
> 
> On Mon, 3 Jan 2005 13:21:02 +0000 (UTC), Roey Katz
> <roey@sdf.lonestar.org> wrote:
>> Dmitry,
>>
>> kernel bootup, syslog and dmesg outputs are here:
>>
>>   http://roey.freeshell.org/mystuff/kernel/
>>
>> all end in "-20050103"
>>
>> This is with "acpi=off" as you instructed.
>>
>
> That is even wierdier. The keyboard controller does not respond to the
> most basic command. I have seen one report of this happening
> (http://bugme.osdl.org/show_bug.cgi?id=3830) but acpi=off helped in
> that case. I wonder, when you tried acpi=off, did you power off your
> box or just rebooted?
>
> The big input update went in with 2.6.9-rc2-bk4. Could you please try
> bk3 and bk4 to verify that this update is causing the problems or we
> shoudl look elsewhere.
>
> I am CCing Vojtech, maybe he has some ideas...
>
> -- 
> Dmitry
>
