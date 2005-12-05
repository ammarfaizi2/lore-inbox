Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVLESim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVLESim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVLESim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:38:42 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:2289 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932509AbVLESil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:38:41 -0500
Message-ID: <4394892D.2090100@gentoo.org>
Date: Mon, 05 Dec 2005 13:38:37 -0500
From: Joseph Jezak <josejx@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Benc <jbenc@suse.cz>
CC: mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz>
In-Reply-To: <20051205190038.04b7b7c1@griffin.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Why yet another attempt to write 802.11 stack? Sure, the one currently
 > in the kernel is unusable and everybody knows about it. But why not to
 > improve code opensourced by Devicescape some time ago instead of
 > inventing the wheel again and again? Yes, I know that code is not
 > perfect and needs a lot of work, but it is the best piece of code we
 > have available now. And it _does_ support WPA and such - in fact, it
 > is nearly complete.
 >
 > Please take a look at http://kernel.org/pub/linux/kernel/people/jbenc/

We're not writing an entire stack.  We're writing a layer that sits in 
between the current ieee80211 stack that's already present in the kernel 
and drivers that do not have a hardware MAC.  Since ieee80211 is already 
in use in the kernel today, this seemed like a natural and useful 
extension to the existing code.  I agree that it's somewhat wasteful to 
keep rewriting 802.11 stacks and we considered other options, but it 
seemed like a more logical choice to work with what was available and 
recommended than to use an external stack.

-Joe
