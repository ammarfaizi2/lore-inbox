Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTFFWJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 18:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTFFWJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 18:09:19 -0400
Received: from miranda.zianet.com ([216.234.192.169]:61195 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S262312AbTFFWJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 18:09:17 -0400
Message-ID: <3EE1143A.9030801@zianet.com>
Date: Fri, 06 Jun 2003 16:22:50 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Smart Array driver
References: <3EE0D5E0.4060408@zianet.com> <16096.59965.283412.477292@gargle.gargle.HOWL> <3EE0F90C.8030604@zianet.com>
In-Reply-To: <3EE0F90C.8030604@zianet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I lied.  I am back to the question of does the driver work
correctly with 2.5.x.  I see it recognize the hardware on bootup
but it can't ever find the root partition.

Here is the df of it on a 2.4.x system

/dev/cciss/c0d0p2    280132792   2405636 263497184   1% /

So they grub kernel config line looks like so

kernel /vmlinuz-2.5.70 ro root=/dev/cciss/c0d0p2

I get this on boot up with 2.5.x:

VFS: Cannot open root device "/cciss/c0d0p2" or unknown-block(0,0)

I don't see what I have wrong in my configs.
Has anyone been able to boot off this RAID controller under 2.5.x?

Steve


kwijibo@zianet.com wrote:

> Argh, I thought I had checked that option.  That option
> was off and it worked when I turned it on. It didn't boot
> all the way because the kernel didn't understand the
> / label on the partition.  Something I can fix however.
>
> Thanks.
>
> John Stoffel wrote:
>
>> kwijibo> Is the Compaq Smart Array 5XXX driver 2.5.x ready?  Before I
>> kwijibo> get to far into debugging this computer I figure I would ask.
>> kwijibo> It boots fine in 2.4.x kernels but when I try 2.5.70 it
>> kwijibo> freezes at the Uncompressing Linux line.  I thought maybe I
>> kwijibo> didn't the console set up right for 2.5 but as far as I can
>> kwijibo> tell it is and even if it wasn't it should still continue
>> kwijibo> booting and eventually be pingable.  My first thought was of
>> kwijibo> the RAID controller.  This is on a HP Proliant ML530.  Any
>> kwijibo> suggestions?  Config attached.
>>
>> I was going to suggest that you make sure ACPI was turned off, but
>> your config shows that already.  Make sure you have CONFIG_VGA_CONSOLE
>> set is all I can think of.
>>
>> John
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>>  
>>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


