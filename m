Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVERELV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVERELV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVERELV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:11:21 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:59820 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262075AbVERELT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:11:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rLM7JsZcFbS7Xvxtlz6HundulJLHRyDlQ3CwEVHeWbBH/y8kna/H/jz6Mfb+sozNa+vXR0cNWIRkpntbh2B16utpeduZYHNbFBTHMMjRRiCKMypOt6H8LaYdrL+H5VZ/qChcEhYYpOSNZh6hihk5udXoQ6AlSBAE+QR5Cu1hvQk=
Message-ID: <311601c905051721114040b08a@mail.gmail.com>
Date: Tue, 17 May 2005 22:11:19 -0600
From: "Eric D. Mudama" <edmudama@gmail.com>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4289652B.7020408@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43Bnu-Ut-9@gated-at.bofh.it> <44sLm-3Mg-33@gated-at.bofh.it>
	 <44sUX-42h-11@gated-at.bofh.it> <44teb-4fb-1@gated-at.bofh.it>
	 <44uaj-4Z3-5@gated-at.bofh.it> <44LXu-2W6-15@gated-at.bofh.it>
	 <44OVj-5xS-3@gated-at.bofh.it> <44PRr-6mz-33@gated-at.bofh.it>
	 <4289652B.7020408@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/05, Robert Hancock <hancockr@shaw.ca> wrote:
> If the power to the drive is truly just cut, then this is basically what
> will happen. However, I have heard, for what it's worth, that in many
> cases if you pull the AC power from a typical PC, the Power Good signal
> from the PSU will be de-asserted, which triggers the Reset line on all
> the buses, which triggers the ATA reset line, which triggers the drive
> to finish writing out the sector it is doing. There is likely enough
> capacitance in the power supply to do that before the voltage drops off.

Yes, but as you said this isn't a power loss event.  It is a hard
reset with a full write cache, which all drives on the market today
respond to by flushing the cache.

According to the spec the time to flush can exceed 30s, so your PSU
better have some honkin caps on it to ensure data integrity when you
yank the power cord out of the wall.

--eric
