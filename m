Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262629AbRFFE4H>; Wed, 6 Jun 2001 00:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbRFFEz4>; Wed, 6 Jun 2001 00:55:56 -0400
Received: from james.kalifornia.com ([208.179.59.2]:36391 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S262629AbRFFEzr>; Wed, 6 Jun 2001 00:55:47 -0400
Message-ID: <3B1DB7CB.5090509@blue-labs.org>
Date: Tue, 05 Jun 2001 21:55:39 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i686; en-US; rv:0.9+) Gecko/20010602
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac9
In-Reply-To: <20010605234928.A28971@lightning.swansea.linux.org.uk> <3B1DB270.6070603@blue-labs.org> <3B1DB3EC.AF7034@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite positive it's the right map file.  I used -m and specified the 
exact file.

David

Jeff Garzik wrote:

>David Ford wrote:
>
>> >>EIP; c01269f9 <proc_getdata+4d/154>   <=====
>>Trace; c01b1021 <read_eeprom+131/1a8>
>>Trace; c01b1c43 <rtl8139_tx_timeout+143/148>
>>Trace; c01b2643 <rtl8139_interrupt+5f/170>
>>Trace; c0137fc0 <__emul_lookup_dentry+a4/fc>
>>Trace; c0138871 <open_namei+4d1/560>
>>Trace; c0167ccb <leaf_define_dest_src_infos+1a7/1ac>
>>Trace; c012e389 <do_readv_writev+15d/228>
>>Trace; c012e2c2 <do_readv_writev+96/228>
>>
>
>This trace looks corrupted to me... are you sure that System.map for the
>crashed kernel matches -exactly- with the one ksymoops used to decode
>this?  It uses /proc/ksyms by default, which is incorrect for most
>postmortem ksymoops runs...
>
>rtl8139_interrupt doesn't call tx_timeout, which doesn't call
>read_eeprom, which doesn't call proc_getdata.
>


