Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbTF3Sp5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 14:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTF3Sp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 14:45:57 -0400
Received: from mx2.idealab.com ([64.208.8.4]:28909 "EHLO butch.idealab.com")
	by vger.kernel.org with ESMTP id S264932AbTF3Sp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 14:45:56 -0400
X-Qmail-Scanner-Mail-From: srini@omnilux.net via butch.idealab.com
X-Qmail-Scanner: 1.03 (Clean. Processed in 6.134806 secs)
From: "Srini" <srini@omnilux.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Process Termination Indication in the Device Driver
Date: Mon, 30 Jun 2003 12:01:53 -0700
Message-ID: <GOEALIFINNJACMGKPLKLGEDMCEAA.srini@omnilux.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1056828251.6296.36.camel@dhcp22.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
   		Thanks for the Reply. Using multiple instances of driver, which inturn
causes the kernel to closes the driver when the application dies is the
approach we
have planned to go about.

Thanks Again
Srini

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Saturday, June 28, 2003 12:24 PM
To: Srini
Cc: Linux Kernel Mailing List
Subject: Re: Process Termination Indication in the Device Driver


On Sad, 2003-06-28 at 00:02, Srini wrote:
> 	I am new to Linux Kernel. I am experimenting with Device Driver in Kernel
> version 2.4. Is there a method by which the device driver could be
indicated
> by the
> kernel of the termination of a "user process" asynchronously.
>
> I know of the function find_task_by_pid that the driver could call to get
> the task
> structure given the pid.

If the application has files open then your device will receive flush
events (and/or release events if its the last open) for each file handle
as it is closed. Linux drivers dont normally care about process exit
information in the general case therefore since the OS will ensure
drivers get told when handles are cleaned up


