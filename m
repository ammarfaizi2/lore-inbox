Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRIET0z>; Wed, 5 Sep 2001 15:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272282AbRIET0q>; Wed, 5 Sep 2001 15:26:46 -0400
Received: from ns.suse.de ([213.95.15.193]:29201 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272280AbRIET0h>;
	Wed, 5 Sep 2001 15:26:37 -0400
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
In-Reply-To: <20010905170037.A6473@emma1.emma.line.org.suse.lists.linux.kernel> <20010905152738.C5912BC06D@spike.porcupine.org.suse.lists.linux.kernel> <20010905182033.D3926@emma1.emma.line.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Sep 2001 21:26:50 +0200
In-Reply-To: Matthias Andree's message of "5 Sep 2001 18:24:12 +0200"
Message-ID: <oupg0a1wi9x.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:
> 
> I believe this would require fixing for compatibility reasons, in the
> sense that the address is also compared to figure the interface, but I'm
> out of time now and cannot try anything before tomorrow, I'd happily
> test patches sent by then.


Even if it checked the address it would not be unique because you can have multiple
interfaces with the same addresses but different netmasks.
The SIOCGIFNETMASK interface is just broken. If you really wanted it you should use
rtnetlink instead, which allows multiple answers to a single question.
Likely postfix doesn't really need it though, the concept of checking for "local"
address is pretty dubious and likely to be incorrect for many cases.

-Andi

