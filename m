Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVKOBNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVKOBNB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVKOBNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:13:01 -0500
Received: from web50115.mail.yahoo.com ([206.190.39.163]:38294 "HELO
	web50115.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751288AbVKOBNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:13:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ff3BmwKAsHQGk44QffTgsnvlFLYvzS7hbzRPz8KaPLpysGtATMtlsl5gMzpyFChOmPv0ikC3gIhvQqZpU482VIZnZDSkQOdMaXIFP3+azqyzBYcydWBD+OJINP4EGfpkaoeR2MBXBvXiIJKZd4AifF91a66Rx2JYEN7Tpz/qhHY=  ;
Message-ID: <20051115011257.825.qmail@web50115.mail.yahoo.com>
Date: Mon, 14 Nov 2005 17:12:57 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [RFC] EDAC and the sysfs
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051115004704.91557.qmail@web50106.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Doug Thompson <norsk5@yahoo.com> wrote:

> What is EDAC and what does it stand for?
> 
> EDAC= Error Detection And Correction.

> > For PCI Parity Error detection controls and
> > information files:
> > 
> >    /sys/devices/system/edac/pci
> 
> That kind of controls and  files?

I left out new PCI whitelist/blacklist control files I
am also working on:

pci_parity_whitelist
pci_parity_blacklist


Since some unmentioned (and expensive) pci boards fail
to conform with the PCI spec when dealing with PCI
parity status reporting (or they just plain have
bugs),  the pci scanning feature needs a whitelist or
a blacklist of "vendor_id:device_id" to specificly
scan or not scan.

If there is a whitelist, no blacklist occurs. When a
blacklist is written to, the whitelist is erased and
devices on blacklist are skipped on the scanning.

format of info to write to these controls, in hex:

vendor_id:device_id[,vendor_id:device_id...]


I have timed both ECC scanning and PCI parity
scanning.

ECC scanning on a dual opteron is 170 TSC clocks.

PCI Parity for 24 devices is 65000 TSC clocks. Ouch! 
When all devices are blacklisted, the iterator is 2700
TSC clocks. 

doug t




"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

