Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbVKYNVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbVKYNVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVKYNVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:21:51 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:53408 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932686AbVKYNVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:21:50 -0500
Subject: Re: [RFC] Small PCI core patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43868DCC.9090101@shaw.ca>
References: <5bsXq-5uy-3@gated-at.bofh.it> <5bsXq-5uy-1@gated-at.bofh.it>
	 <5btqF-66n-41@gated-at.bofh.it> <5bzmg-66b-1@gated-at.bofh.it>
	 <5bHtG-228-23@gated-at.bofh.it>  <43868DCC.9090101@shaw.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Nov 2005 13:54:37 +0000
Message-Id: <1132926878.3298.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-24 at 22:06 -0600, Robert Hancock wrote:
> I suspect the amount of data going through is large enough that this 
> wouldn't really be practical. I think you'd have to deal with the code 
> generating GPU instructions having to be trusted and have the device 
> interface require root privileges..

You may wish to compare your suspicion with the DRI driver for via GPUs
which does exactly this without problem. The majority of video traffic
is not GPU instructions but textures which go via a different route.
Also the GPU streams are generally very clean to parse.

Alan

