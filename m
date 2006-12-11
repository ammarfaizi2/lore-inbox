Return-Path: <linux-kernel-owner+w=401wt.eu-S1762956AbWLKRHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762956AbWLKRHy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762954AbWLKRHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:07:54 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:61880 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762949AbWLKRHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:07:53 -0500
Message-ID: <457D9066.1030308@mvista.com>
Date: Mon, 11 Dec 2006 11:07:50 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Tilman Schmidt <tilman@imap.cc>
Cc: Alan <alan@lxorguk.ukuu.org.uk>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
References: <4533B8FB.5080108@mvista.com>	<20061210201438.tilman@imap.cc>	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>	<457CB32A.2060804@mvista.com> <20061211102016.43e76da2@localhost.localdomain> <457D8E35.9050706@imap.cc>
In-Reply-To: <457D8E35.9050706@imap.cc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tilman Schmidt wrote:
> On Mon, 11 Dec 2006 10:20:16 +0000, Alan wrote:
>   
>> This looks wrong. You already have a kernel interface to serial drivers.
>> It is called a line discipline. We use it for ppp, we use it for slip, we
>> use it for a few other things such as attaching sync drivers to some
>> devices.
>>     
>
> I was under the impression that line disciplines need a user space
> process to open the serial device and push them onto it. Is there
> a way for a driver to attach to a serial port through the line
> discipline interface from kernel space, eg. from an initialization,
> module load, or probe function?
>   
Module initialization functions run in a task context, so that's
generally not a problem.  The probe function depends on the driver,
I guess, but most I have seen are in task context.

-Corey

