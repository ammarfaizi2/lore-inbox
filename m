Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992823AbWJUDdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992823AbWJUDdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 23:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992824AbWJUDdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 23:33:54 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:23489 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S2992823AbWJUDdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 23:33:54 -0400
Date: Fri, 20 Oct 2006 21:33:53 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.19-rc2 ipw2200 breakage with wpa_supplicant
In-reply-to: <45399093.6090306@shaw.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: yi.zhu@intel.com, jketreno@linux.intel.com
Message-id: <45399521.30502@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <45399093.6090306@shaw.ca>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Something changed between 2.6.18-mm1 and 2.6.19-rc2 to cause my laptop's 
> ipw2200 to be unable to associate with the access point using 
> NetworkManager and wpa_supplicant. I keep seeing this kind of thing over 
> and over in the wpa_supplicant output:

It looks like the bad patch is this one. Reverting it makes it work 
again. Either there's a bug in here or it's a change breaking working 
userspace, either way, no good:

[PATCH] WE-21 for ipw2200

author	Jean Tourrilhes <jt@hpl.hp.com>
	Wed, 30 Aug 2006 01:01:40 +0000 (18:01 -0700)
committer	John W. Linville <linville@tuxdriver.com>
	Mon, 25 Sep 2006 20:52:16 +0000 (16:52 -0400)
commit	919ee6ddcd3fcff09dee90c11af17a802196ad1f
tree	c45e35201d7a3f2c998fc316898f902fd85fdfd2
parent	b978d0278c3a4c41bda806743c6ef5dca86b4c61

[PATCH] WE-21 for ipw2200

Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
