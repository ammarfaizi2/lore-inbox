Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263334AbRF0Piu>; Wed, 27 Jun 2001 11:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263340AbRF0Pia>; Wed, 27 Jun 2001 11:38:30 -0400
Received: from ns.suse.de ([213.95.15.193]:23826 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263334AbRF0PiX>;
	Wed, 27 Jun 2001 11:38:23 -0400
To: "Jens Hoffrichter" <HOFFRICH@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: printk and sk_buffs
In-Reply-To: <OFC7C24EA9.6CB8EE5C-ONC1256A78.004CC2C0@de.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Jun 2001 17:38:20 +0200
In-Reply-To: "Jens Hoffrichter"'s message of "27 Jun 2001 16:07:46 +0200"
Message-ID: <oup7kxy3pcj.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jens Hoffrichter" <HOFFRICH@de.ibm.com> writes:

> I do not fully unterstandt the printk code, so perhaps somebody can answer
> me this (probably stupid ;) ) question:
> 
> If I do a printk, is there a packet (aka a sk_buff) created? If I turn on
> debugging in my code, I see a huge pile of sk_buffs which are allocated but
> which do not get in touch with the "essential" parts of the network-code
> (e.g. ip_rcv) where I have modified some code. I can't explain it to me
> fully, but perhaps someone of yours has a suitable answer.

klogd uses unix sockets to talk to syslogd. unix sockets use sk_buffs.
You can kill klogd if you're not interested in logging kernel messages to disk.

-Andi
