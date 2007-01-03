Return-Path: <linux-kernel-owner+w=401wt.eu-S1750755AbXACN1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbXACN1s (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXACN1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:27:48 -0500
Received: from twin.jikos.cz ([213.151.79.26]:38322 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbXACN1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:27:47 -0500
X-Greylist: delayed 3240 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 08:27:47 EST
Date: Wed, 3 Jan 2007 13:33:40 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Florin Iucha <florin@iucha.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2
In-Reply-To: <20061225224047.GB6087@iucha.net>
Message-ID: <Pine.LNX.4.64.0701031119190.1665@twin.jikos.cz>
References: <20061225224047.GB6087@iucha.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Dec 2006, Florin Iucha wrote:

> I left the machine to run the diff and when I came back, the USB 
> keyboard was unresponsive although the USB mice plugged in the hub built 
> into the keyboard were working fine.  I was able to ssh into the box, 
> capture the dmesg and reboot.  Everything went down quietly but the box 
> froze at the "... will restart".  I had no working keyboard and no way 
> to see if it was indeed frozen or not.

Hi Florin,

I have not seen any similar bugreports, but it seems that you are able to 
reproduce the problem reliably to some extent.

Do you think that you could try to narrow down whether the HID core 
patches that went to 2.6.20-rc1 might possibly be causing your problem?

The easiest way might probably be just reverting the following commits and 
see if you can still reproduce the problems. It would be nice if you could 
try, so that we know whether it is caused by HID core, or any other 
post-2.6.19 USB/input changes.

10f549fa1538849548787879d96bbb3450f06117
4ef4caad41630c7caa6e2b94c6e7dda7e9689714
1c1e40b5ad6e345feba69bc612db006efccf4cdc
e3a0dd7ced76bb439ddeda244a9667e7b3800fc8
63f3861d2fbf8ccbad1386ac9ac8b822c036ea00
4c2ae844b5ef85fd4b571c9c91ac48afa6ef2dfc
aa8de2f038baec993f07ef66fb3e94481d1ec22b
aa938f7974b82cfd9ee955031987344f332b7c77
4916b3a57fc94664677d439b911b8aaf86c7ec23
229695e51efc4ed5e04ab471c82591d0f432909d
dde5845a529ff753364a6d1aea61180946270bfa
64bb67b1702958759f650adb64ab33496641e526

They should be revertible without conflict in this order.

Thanks,

-- 
Jiri Kosina
