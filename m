Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132702AbRDIH7e>; Mon, 9 Apr 2001 03:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132704AbRDIH7Y>; Mon, 9 Apr 2001 03:59:24 -0400
Received: from [195.224.53.219] ([195.224.53.219]:18560 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S132702AbRDIH7O>;
	Mon, 9 Apr 2001 03:59:14 -0400
Date: Mon, 09 Apr 2001 08:59:07 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Sources of entropy - /dev/random problem for network servers
Message-ID: <1490543406.986806747@[195.224.237.69]>
In-Reply-To: <3AD0F553.BE6BBF71@mandrakesoft.com>
In-Reply-To: <3AD0F553.BE6BBF71@mandrakesoft.com>
X-Mailer: Mulberry/2.1.0a4 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff et al.,

>> However, only 3 drivers in drivers/net actually set
>> SA_SAMPLE_RANDOM when calling request_irq(). I believe
>> all of them should.
>
> No, because an attacker can potentially control input and make it
> non-random.

Point taken but:
1. In that case, if we follow your logic, no drivers (rather than 3
   arbitrary ones) should set SA_SAMPLE_RANDOM
2. Given that otherwise in at least my application (and machine
   without keyboard and mouse can't be too uncommon) there is *no*
   entropy otherwise, which is rather easier for a hacker. At least
   with entropy from a (albeit predictable) network, his attack
   is going to shift the state of the seed (in an albeit predictable
   manner), though he's going to have to make some accurate guesses
   each time about the forwarding delay of the router in front of it,
   and the stream of other packets hitting the server. I'd rather rely
   on this, than rely on cron (which is effectively what is driving
   any disk entropy every few minutes and is extremely predictable).

--
Alex Bligh
