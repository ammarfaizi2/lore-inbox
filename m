Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268864AbUHLXB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268864AbUHLXB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268854AbUHLXBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:01:55 -0400
Received: from apollo.tuxdriver.com ([24.172.12.4]:61457 "EHLO
	ra.tuxdriver.com") by vger.kernel.org with ESMTP id S268873AbUHLXA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:00:28 -0400
Message-ID: <411BF6A5.2030306@tuxdriver.com>
Date: Thu, 12 Aug 2004 19:00:53 -0400
From: "John W. Linville" <linville@tuxdriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Subject: Re: [patch] 2.6 -- add IOI Media Bay to SCSI quirk list
References: <200408122137.i7CLbGU13688@ra.tuxdriver.com> <20040812225118.GA20904@beaverton.ibm.com>
In-Reply-To: <20040812225118.GA20904@beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:

>We seem to be getting quite a few of these. In theory we could add a line
>like this for every multi-lun SCSI device.
>  
>

Isn't that what the quirk list is for?

>Can you instead try booting with scsi_mod.max_luns=8 (or such) or build
>with SCSI_MULTI_LUN enabled?
>  
>

That works for my box, but what about for others?  Like those who may 
have both a multi-lun device and a single-lun device that hangs on a 
non-zero lun?  What about the average luser who can't be bothered to 
hack-up his startup scripts or *gasp* rebuild his kernel?

It seems like the quirk list is there for a reason.  If we start 
rejecting certain devices, then what is the criteria for a device to 
actually make it on the list?

John
