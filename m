Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287196AbSAHJ0x>; Tue, 8 Jan 2002 04:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287208AbSAHJ0o>; Tue, 8 Jan 2002 04:26:44 -0500
Received: from jalon.able.es ([212.97.163.2]:32721 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S287196AbSAHJ0h>;
	Tue, 8 Jan 2002 04:26:37 -0500
Date: Tue, 8 Jan 2002 10:30:46 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@redhat.com>, "J.A. Magallon" <jamagallon@able.es>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@ns.caldera.de>, Jaroslav Kysela <perex@suse.cz>,
        sound-hackers@zabbo.net, linux-sound@vger.rutgers.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
Message-ID: <20020108103046.A3545@werewolf.able.es>
In-Reply-To: <20020108102833.A2927@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020108102833.A2927@werewolf.able.es>; from jamagallon@able.es on Tue, Jan 08, 2002 at 10:28:33 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020108 Linus Torvalds wrote:
>
>On Mon, 7 Jan 2002, Alan Cox wrote:
>> > Would't it be better to split drivers:
>> >
>> > sound/core.c
>> > sound/alsa/alsa-core.c
>> > sound/alsa/drivers/alsa-emu10k.c
>> > sound/oss/oss-core.c
>> > sound/oss/drivers/oss-emu10k.c
>>
>> Thats much harder to do randomg greps on and to find stuff,than drivers
>> first
>
>I agree. Put drivers separately, let's not split it up more than that.
>

What would you do with drivers with the same name (source code file)
in alsa and oss ?
Sound is special because you have two implementations of the same subsystem
living together. And eventually in a (near?) future, the oss subtree
will be killed and the alsa one would go up one level, just as is. Much
cleaner. And you will end with

sound/alsa-core.c
sound/drivers/alsa-driver.c

By

/juan

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre2-beo #1 SMP Tue Jan 8 03:18:18 CET 2002 i686
