Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbULTJEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbULTJEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULTJEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:04:06 -0500
Received: from mout.alturo.net ([212.227.15.21]:48889 "EHLO mout.alturo.net")
	by vger.kernel.org with ESMTP id S261248AbULTJDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:03:31 -0500
Message-ID: <41C694E0.8010609@informatik.uni-bremen.de>
Date: Mon, 20 Dec 2004 10:01:20 +0100
From: Arne Caspari <arnem@informatik.uni-bremen.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
References: <20041220015320.GO21288@stusta.de>
In-Reply-To: <20041220015320.GO21288@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

Some of these symbols are used by the open source driver "video-2-1394" 
( http://sourceforge.net/projects/video-2-1394 ).

This driver is supported by The Imaging Source Europe GmbH and used by 
quite a few of our customers. For most of these customers, it is OK to 
compile the driver but not to modify the kernel source.

Please please, do not break the kernel API out of the blue. Supporting a 
Linux driver is already very frustrating. Currently it is a lot more 
convenient for our customers to switch to Windows just because the 
installation and use of the software is much easier there - or at least 
it is easy enough there to handle the installation where it is not on Linux.

Breaking the API now will most likely stop The Imaging Source from 
supporting open source driver development anymore. We just can not 
effort any unneccessary development anymore. We are already blocked by 
shortcomings in the LDM and bugs in the Linux driver handling ( see my 
posings about a hotplugging issue and about the issue that IEEE-1394 
modules can not be unloaded ).

Thanks and best regards,

Arne Caspari

The Imaging Source Europe GmbH




Adrian Bunk wrote:
> The patch below removes 41 unneeded EXPORT_SYMBOL's.
> 
> 
> diffstat output:
>  drivers/ieee1394/ieee1394_core.c |   41 -------------------------------
>  1 files changed, 41 deletions(-)
