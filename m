Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWGTUmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWGTUmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 16:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWGTUmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 16:42:16 -0400
Received: from mail.smartlink.ee ([213.180.16.242]:21896 "EHLO
	mail.smartlink.ee") by vger.kernel.org with ESMTP id S964901AbWGTUmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 16:42:15 -0400
Message-ID: <44BFEAA5.5030703@smartlink.ee>
Date: Thu, 20 Jul 2006 23:42:13 +0300
From: Kalev Lember <kalev@smartlink.ee>
User-Agent: Thunderbird 1.5.0.4 (X11/20060610)
MIME-Version: 1.0
To: Gerd Hoffmann <kraxel@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kexec and framebuffer
References: <44BB9A7A.4060100@smartlink.ee> <44BB9EB3.9020101@suse.de>
In-Reply-To: <44BB9EB3.9020101@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann wrote:
>> I am wondering what would be the preferred method to extract screen_info
>> from running kernel. Should this be made available from sysfs or maybe a
>> new system call be created?
>>     
>
> Simply ask /dev/fb0?
> Patch for kexec tools attached.
>   
Thank you, this was really helpful.
> +	if (0 != strcmp(fix.id, "vesafb"))
> +		goto out;
I think this check should be removed so that other framebuffer drivers
besides vesafb would also work. Additionally the fix.id is "VESA VGA",
not "vesafb".

Could you please submit this for inclusion in kexec-tools or do you want
me to do it?

-- 
Kalev Lember
