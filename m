Return-Path: <linux-kernel-owner+w=401wt.eu-S1161316AbXAHOYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbXAHOYE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 09:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161315AbXAHOYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 09:24:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:61193 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161305AbXAHOYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 09:24:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cR+dtklx6HVnq4pI9uSj3HF0ggj9DAkjJ5qfVeYBwDku/1iOnA9Y41Vqws7Rk1wW8Y1shkIwkXppaaQi/kt9BMw3uZIzEvcaIgf7/fUQzl8kveazBywhFeH+TTxL8wgSCRqIEnsUK5KMg9jiswlkIgmBVw72YYC8/dHTLtbR5vU=
Message-ID: <45A253A2.2040407@gmail.com>
Date: Mon, 08 Jan 2007 15:22:26 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: "Dimitar G. Katerinski" <dgk@tropot.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE discovered as SATA - 2.6.20-rc4
References: <200701081544.43153.dgk@tropot.net>
In-Reply-To: <200701081544.43153.dgk@tropot.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2007 02:44 PM, Dimitar G. Katerinski wrote:

> After some investigation, I find out that my IDE chipset is being discovered 
> as SATA, so my hard drive is not /dev/hda, but /dev/sda.

It seems you compiled in support for "PATA", more specifically for:

> 00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)

"<*> AMD/NVidia PATA support (Experimental)"

in the "Serial ATA (prod) and Parallel ATA (experimental) drivers" menu 
under "Device Drivers". PATA is what is also known as IDE and the PATA 
drivers are a new set of IDE drivers, using the same infrastructure as 
SCSI and SATA (and USB, and ..). Yes, they're newly integrated in 
2.6.20. One of the advatages of these new drivers are better error 
handling than the old IDE driver.

I'm using that same specific driver by the way (on amd756) and it's 
working very nicely for me.

Rene.
