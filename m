Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbTEAT4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 15:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTEAT4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 15:56:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9882
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262265AbTEAT4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 15:56:13 -0400
Subject: Re: How to notify a user process from within a driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Lee, Shuyu" <SLee@cognex.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <6AF24836F3EB074BA5C922466F9E92E10791B52F@prince.pc.cognex.com>
References: <6AF24836F3EB074BA5C922466F9E92E10791B52F@prince.pc.cognex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051816166.21446.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 20:09:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-01 at 20:23, Lee, Shuyu wrote:
> Hello, All.
> 
> I am working on a device driver. One of the features of the hardware is
> multi-channel I/O control. In order for a user process to communicate with
> the hardware, my design is for the user process to call the driver's ioctl
> to register a semaphore for each I/O channel, 

For event waiting look at poll/select not at the SYS5 semaphore stuff
which is really an old compat hack for weird stuff AT&T did years ago.

