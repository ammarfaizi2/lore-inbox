Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbTK0MII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 07:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTK0MII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 07:08:08 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:47876 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264502AbTK0MIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 07:08:05 -0500
Subject: Re: PROBLEM: trouble with usb mouse after suspending
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Titus v. d. Malsburg" <malsburg@cl.uni-heidelberg.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <08328644-20CE-11D8-AE92-003065B33FF0@cl.uni-heidelberg.de>
References: <08328644-20CE-11D8-AE92-003065B33FF0@cl.uni-heidelberg.de>
Content-Type: text/plain
Message-Id: <1069934862.2393.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 27 Nov 2003 13:07:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-27 at 12:37, Titus v. d. Malsburg wrote:

> [2.] Full description of the problem/report:
> Notebook has a synaptics touchpad and a logitech usb mouse attached.  
> Sending the notebook to sleep by apm --suspend and wake it afterwards 
> yields the following (boot procedure is included as well): 
> (/var/log/messages)

> Nov 27 11:52:50 vlana kernel: uhci_hcd 0000:00:07.2: UHCI Host 
> Controller

I think this is the problem: you're using UHCI-HCD. Please, correct me
if I'm wrong but, currently, UHCI-HCD does not work properly after
resuming from suspend (either APM or ACPI).

I have to remote the uhci-hcd module before going to sleep and then,
after waking up, I modprobe it back. At least, It Works For Me(TM) :-)

