Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265623AbUABTXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbUABTXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:23:55 -0500
Received: from firewall.conet.cz ([213.175.54.250]:48540 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265623AbUABTXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:23:53 -0500
Message-ID: <3FF5C52D.6050208@conet.cz>
Date: Fri, 02 Jan 2004 20:23:25 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il>	 <3FF59073.3060305@conet.cz> <20040102160020.A24026@infradead.org>	 <20040102163552.GD31489@wohnheim.fh-wedel.de> <3FF5A36A.5070501@conet.cz>	 <20040102180431.GB6577@wohnheim.fh-wedel.de>  <3FF5BF68.8060303@conet.cz> <1073070944.9343.0.camel@laptop.fenrus.com>
In-Reply-To: <1073070944.9343.0.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, 2004-01-02 at 19:58, Libor Vanek wrote:
> 
>>On Fri, Jan 02, 2004 at 07:04:31PM +0100, Jörn Engel wrote:
>>
>>>On Fri, 2 January 2004 17:59:22 +0100, Libor Vanek wrote:
>>>
>>>>>My guess is that the filesystem change notification would be a better
>>>>>solution, either in userspace or in kernelspace, doesn't matter.  But
>>>>>that is far from finished or even generally accepted.
>>>>
>>>>This is also something (but just a bit) different - I don't need "change 
>>>>notification" but "pre-change notification" ;)
>>>
>>>"Vor dem Spiel ist nach dem Spiel" -- Sepp Herberger
>>>
>>>Except for exactly two cases, pre-change and post-change and the same,
>>>just off-by-one.  So you would need a bootup/mount/whenever special
>>>case now, is that a big problem?
>>
>>Probably my english is bad but I don't understand what are you trying to say (except the german part ;-))
>>A bit more about pre/post-change (if this is what are you trying to say) - I need allways pre-change because after file is changed I can no longer get original (pre-change) version of file which I need for snapshot.
> then you are off on the wrong track anyway since filedata can change
> without system call anyway (think mmaped file where the dirtying doesnt'
> involve a syscall

I know about this - the only (simple and fast enough) solution is to copy (backup) file whenever it's open for writing and mmap is called.


-- 

Libor Vanek



