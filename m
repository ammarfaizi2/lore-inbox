Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRDHXeF>; Sun, 8 Apr 2001 19:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131300AbRDHXdz>; Sun, 8 Apr 2001 19:33:55 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52431 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131289AbRDHXdm>;
	Sun, 8 Apr 2001 19:33:42 -0400
Message-ID: <3AD0F553.BE6BBF71@mandrakesoft.com>
Date: Sun, 08 Apr 2001 19:33:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sources of entropy - /dev/random problem for network servers
In-Reply-To: <1457842476.986773581@[195.224.237.69]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel wrote:
> The machine in question is locked in a data center (can't be
> the only one) and thus sees none of the former two. IDE Entropy
> comes from executed IDE commands. The disk is physically largely
> inactive due to caching. But there's plenty of network traffic
> which should generate IRQs.

Use a hardware random number generator if you need a lot of entropy. 
The i810 RNG driver and userspace tools at
http://sourceforge.net/project/gkernel/ provide an example for an
implementation, if your hardware is not i8xx.


> However, only 3 drivers in drivers/net actually set
> SA_SAMPLE_RANDOM when calling request_irq(). I believe
> all of them should.

No, because an attacker can potentially control input and make it
non-random.

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
