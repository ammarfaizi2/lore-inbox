Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWHaUy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWHaUy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 16:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWHaUy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 16:54:27 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:37802 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP id S932448AbWHaUy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 16:54:27 -0400
Message-ID: <44F74C66.7000705@nortel.com>
Date: Thu, 31 Aug 2006 14:53:58 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Xavier Bestel <xavier.bestel@free.fr>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
References: <20060830062338.GA10285@kroah.com> <1157013027.7566.515.camel@capoeira> <1157056749.4386.137.camel@mindpipe>
In-Reply-To: <1157056749.4386.137.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2006 20:54:01.0825 (UTC) FILETIME=[96801D10:01C6CD3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> Why?  There's no technical or legal requirement for userspace drivers to
> be GPLed.

I could see a benefit to tainting the kernel once userspace starts 
poking at the hardware directly.  That way at least we'd know that a 
crash might be due to userspace doing bad things.

For instance, consider the case where userspace misprograms a DMA 
engine, which starts overwriting random kernel memory.

Chris
