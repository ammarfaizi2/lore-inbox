Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVCAOlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVCAOlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 09:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVCAOlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 09:41:11 -0500
Received: from magic.adaptec.com ([216.52.22.17]:26011 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261927AbVCAOk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 09:40:56 -0500
Message-ID: <42247EF0.9000404@adaptec.com>
Date: Tue, 01 Mar 2005 09:40:48 -0500
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Adrian Bunk <bunk@stusta.de>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI: possible cleanups
References: <20050228213159.GO4021@stusta.de> <4224245E.6090503@torque.net>
In-Reply-To: <4224245E.6090503@torque.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Mar 2005 14:40:51.0852 (UTC) FILETIME=[AAAA5CC0:01C51E6C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/05 03:14, Douglas Gilbert wrote:
>>   - scsi_error.c: scsi_normalize_sense
> 
> 
> I introduced scsi_normalize_sense() recently, Christoph H.
> proposed it should be static but Luben Tuikov (aic7xxx
> maintainer) said he wished to use it in the future.
> Hence it was left global.

Hi guys,

I think the idea of normalized sense is very good.
Basically the question is if LLDD would submit normalized
sense to SCSI Core or whether they would submit a pointer
to raw sense data as returned by the device and let SCSI
Core decipher it.

If the former, then it should be global, if the latter then
it should be static to SCSI Core.

	Luben
