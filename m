Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVHYNo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVHYNo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVHYNo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:44:58 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:31686 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S964982AbVHYNo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:44:57 -0400
Message-ID: <430DCB58.1090107@dgreaves.com>
Date: Thu, 25 Aug 2005 14:44:56 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: michael_e_brown@dell.com, matt_domsch@dell.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc6] dcdbas: add Dell Systems Management Base Driver
 with sysfs support
References: <20050820225052.GA5042@sysman-doug.us.dell.com>
In-Reply-To: <20050820225052.GA5042@sysman-doug.us.dell.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Warzecha wrote:

>This patch adds the Dell Systems Management Base Driver with sysfs support.
>
>This patch incorporates changes based on comments from the previous posting.
>
>Summary of changes:
>
>* Changed permissions on sysfs files so that only owner can read.
>* Changed to use __uNN/__sNN types in structs.
>* smi_data_write will grow smi_data_buf if needed.
>* Renamed struct callintf_cmd to struct smi_cmd.
>* Renamed callintf_smi to smi_request.
>* Added 2 more supported values that were requested in smi_request_store.
>* Hold rtc_lock across SMI in host_control_smi.
>
>  
>
Hi Doug

I've followed this thread as best I can and I have a query...

I have a Dell SC420
Is there a way (based around this patch) to allow users to enable and
set the auto-power-on BIOS feature?
(ie tell the BIOS to power on at 3:40am, power the system down, watch it
power up at 3:40am)

Normally I'd use 'nvram-wakeup' but it dosen't understand the Dell BIOS.

If so what I'd _like_ to do is send a patch to nvram-wakeup that tests
for this capability and uses it if it's there.

David

-- 

