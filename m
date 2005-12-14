Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVLNQ4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVLNQ4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVLNQ4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:56:15 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:22756 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964862AbVLNQ4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:56:13 -0500
Message-ID: <43A04E73.2020808@de.ibm.com>
Date: Wed, 14 Dec 2005 17:55:15 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>, Andreas Herrmann <AHERRMAN@de.ibm.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-scsi@vger.kernel.org
Subject: Re: [patch 6/6] statistics infrastructure - exploitation: zfcp
References: <43A044E6.7060403@de.ibm.com> <20051214162437.GW9286@parisc-linux.org>
In-Reply-To: <20051214162437.GW9286@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Wed, Dec 14, 2005 at 05:14:30PM +0100, Martin Peschke wrote:
> 
>> 	if (device_register(&unit->sysfs_device)) {
>>+		zfcp_unit_statistic_unregister(unit);
>> 		kfree(unit);
>> 		return NULL;
>> 	}
>>
>> 	if (zfcp_sysfs_unit_create_files(&unit->sysfs_device)) {
>>+		zfcp_unit_statistic_unregister(unit);
>> 		device_unregister(&unit->sysfs_device);
>> 		return NULL;
>> 	}
> 
> 
> Unrelated, but doesn't that error path forget to release unit?
> 
> 

correct, I guess ... Andreas, could you fix this?
