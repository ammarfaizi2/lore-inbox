Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVGaMqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVGaMqi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 08:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVGaMqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 08:46:38 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:37390 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S261730AbVGaMqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 08:46:33 -0400
Message-ID: <42ECC822.7060802@roarinelk.homelinux.net>
Date: Sun, 31 Jul 2005 14:46:26 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org>	<42EC9410.8080107@roarinelk.homelinux.net> <20050731021628.42e3ab98.akpm@osdl.org>
In-Reply-To: <20050731021628.42e3ab98.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
>>something broke the sonypi driver a bit after -mm2:
>> I can no longer set bluetooth-power for instance, and it logs these
>> messages:
>>
>> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 605)
>> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 607)
>> sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 594)
>>
>> setting/getting brightness, getting battery/ac status still work.
>>
> 
> 
> Can you do a `patch -p1 -R' of the below, see if it fixes it?  It probably
> won't.
> 
> Also please test 2.6.13-rc4-mm1 which is missing the acpi tree...
> 
> Thanks.


Found the cause:

 > -revert-gregkh-pci-pci-assign-unassigned-resources.patch
 >
 > Hopefully no longer needed

Applying this dropped patch to -rc3-mm3 and -rc4-mm1 fixes
it.

Thanks,

-- 
  Manuel Lauss
