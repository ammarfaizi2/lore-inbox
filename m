Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWHSFUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWHSFUt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 01:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWHSFUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 01:20:49 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:14419 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750702AbWHSFUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 01:20:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IqyyeLy8LrYhPPD+XmI62lB7bK+15R3mdKzvUVD9YmDSGQXdotsFBG2Vwxd1IqbaULYBh6HBz/ioZlJjmciimva9rfVJEBsh4d5N2UNRH9yAq2CiUPPApLMFdzWseeVit25+J32nXqlJSmg3+f+biwRFm9Vr8TdFCkRiXecmY0A=
Message-ID: <44E69FC7.2040406@gmail.com>
Date: Fri, 18 Aug 2006 23:21:11 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC-patch - make sysfs_create_group skip members with attr.mode
 == 0
References: <44E4F2B1.30408@gmail.com> <20060818014922.GA2622@martell.zuzino.mipt.ru> <44E54137.8030805@gmail.com> <200608190019.01389.dtor@insightbb.com>
In-Reply-To: <200608190019.01389.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Friday 18 August 2006 00:25, Jim Cromie wrote:
>   
>> With this patch, atts 4..N can be disabled at runtime,
>> by setting mode = 0.  Afterwards, when sysfs_group_create
>> is called, it creates attr-files *only* for those whose
>> mode != 0.  IOW - no attr-files for non-existent hardware.
>> Normally, mode is set usefully, and attr-files
>> are created as normal.
>>
>>     
patch trimmed
>
> Unfortunately this does not work too well if your box happen to have
> 2 or more different chips served by the same driver as you fiddle with
> the static array of attributes shared by all device instances.
>
>   

Ack, yes.  Thats become clear over on lm-sensors.
Kinda spoils the supposed generality..

thanks
