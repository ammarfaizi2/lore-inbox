Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264064AbUKAWRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264064AbUKAWRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S325749AbUKAWOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:14:49 -0500
Received: from proxy.vc-graz.ac.at ([193.171.121.30]:10724 "EHLO
	proxy.vc-graz.ac.at") by vger.kernel.org with ESMTP id S292292AbUKATkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:40:41 -0500
From: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Subject: Re: 2.6.9 USB storage problems
Date: Mon, 1 Nov 2004 20:40:32 +0100
User-Agent: KMail/1.7
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
References: <200410121424.59584.worf@sbox.tu-graz.ac.at> <200411011850.47870.worf@sbox.tu-graz.ac.at> <20041101191036.GA18227@one-eyed-alien.net>
In-Reply-To: <20041101191036.GA18227@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411012040.33285.worf@sbox.tu-graz.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 1. November 2004 20:10 schrieb Matthew Dharm:
> You're using the UB driver.  Does it work if you turn that off and use the
> usb-storage driver instead?

Damn, you are right - this is a new driver...
I didn't notice that, i did rely on hotplug to load the correct modules.

Removed the ub driver and everything is fine now.

That means - just unloadin ub and loading usb-storage didn't work. 

I had to remove it from the kernel config and rebuild the modules. Actually 
usb-storage was the only module being rebuilt. Looks like usb-storage's 
functionality is different if ub is built.

So, my system works fine again, thank you.
But it leaves the question: why does ub perform so badly?

And: could maybe somebody put some hints into the ub help?
"This driver supports certain USB attached storage devices such as flash 
keys." didn't sound so bad to me...

Worf
