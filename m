Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbRGOUam>; Sun, 15 Jul 2001 16:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbRGOUac>; Sun, 15 Jul 2001 16:30:32 -0400
Received: from [213.97.184.209] ([213.97.184.209]:48800 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S267003AbRGOUaO>;
	Sun, 15 Jul 2001 16:30:14 -0400
Date: Sun, 15 Jul 2001 22:30:20 +0200
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Processor priority in the scheduler (entry in /proc ?)
Message-ID: <20010715223020.A28310@hal9000.piraos.com>
In-Reply-To: <20010715211107.A22691@hal9000.piraos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010715211107.A22691@hal9000.piraos.com>; from german@piraos.com on Sun, Jul 15, 2001 at 21:11:07 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

 I would like to know if there is any patch available that implement some
kind of interface under /proc to set the priority of each processor (in SMP)
in the scheduler. I would like to make a daemon that monitor the temp
sensors and fan speeds, so it can keep both of them at the lowest temp by
setting priority to the cooler processor. Even it could be possible to
really stop one processor making it almost impossible to "win" in a
scheduler competition between the two (or more processor). This way you can
prevent damage if one of the fans get broken. I'm sure other people would
find interesting uses for such an interface to the kernel.

 And such an interface should be trivial (or at least quite easy :-) to
implement. Even just a /proc/sys/kernel/scheduler directory with entries for
each processor (0,1, etc) and a number (say from 0 to 65535 ?) originally
set equal for all and writable by root ... that denote some kind of weighted
probabilty to choose that processor, with 0 means no posibility, and be sure
that not all of them are 0 simultaneously. 

	Regards,

	- german

PS: Please CC to me as I'm not subscribed to the kernel list.
-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject 
<german@piraos.com>          | to receive my GnuPG public key.
