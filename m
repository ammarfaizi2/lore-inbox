Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbTF1TOP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbTF1TOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:14:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47498
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265405AbTF1TMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:12:50 -0400
Subject: Re: Process Termination Indication in the Device Driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Srini <srini@omnilux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <GOEALIFINNJACMGKPLKLIECNCEAA.srini@omnilux.net>
References: <GOEALIFINNJACMGKPLKLIECNCEAA.srini@omnilux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056828251.6296.36.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 20:24:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-28 at 00:02, Srini wrote:
> 	I am new to Linux Kernel. I am experimenting with Device Driver in Kernel
> version 2.4. Is there a method by which the device driver could be indicated
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

