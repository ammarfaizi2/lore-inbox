Return-Path: <linux-kernel-owner+w=401wt.eu-S932783AbWLaVdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbWLaVdO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 16:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932786AbWLaVdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 16:33:14 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:60916 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932783AbWLaVdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 16:33:13 -0500
Date: Sun, 31 Dec 2006 22:30:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Miller <davem@davemloft.net>
cc: wmb@firmworks.com, devel@laptop.org, linux-kernel@vger.kernel.org,
       jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
In-Reply-To: <20061231.124531.125895122.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0612312230070.29991@yvahk01.tjqt.qr>
References: <459714A6.4000406@firmworks.com> <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
 <20061231.124531.125895122.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 31 2006 12:45, David Miller wrote:
>From: Jan Engelhardt <jengelh@linux01.gwdg.de>
>
>> BUT, the eeprom utility may be used to modify values, and if used, I
>> would like to see ofwfs show the updated value. openpromfs does it
>> today:
>> 
>> 15:09 ares:/proc/openprom/options # cat oem-banner?
>> false
>> 15:09 ares:/proc/openprom/options # eeprom 'oem-banner?=true'
>> 15:09 ares:/proc/openprom/options # cat oem-banner?
>> true
>> 
>> (BTW, why does not openpromfs have it rw?)
>
>It used to be able to :-)
>
>When I changed sparc/sparc64 over to an in-memory copy of the
>OFW tree, I wasn't able to retain writable property support
>in openpromfs.  It just needs to be implemented and I never
>found the desire nor time.

However, there is this one pseudofile "security-password" which _is_
writable, what about it?


	-`J'
-- 
