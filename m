Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRBZVJT>; Mon, 26 Feb 2001 16:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbRBZVJK>; Mon, 26 Feb 2001 16:09:10 -0500
Received: from smtp2.nikoma.de ([212.122.128.25]:49672 "EHLO smtp2.nikoma.de")
	by vger.kernel.org with ESMTP id <S129134AbRBZVJH>;
	Mon, 26 Feb 2001 16:09:07 -0500
Date: Mon, 26 Feb 2001 22:03:38 +0100
From: Norbert Nemec <nobbi@cheerful.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ramfs causes system hang when swapping
Message-ID: <20010226220338.A1558@DeepThought>
Reply-To: Norbert Nemec <nobbi@cheerful.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

seems like ramfs lets the system hang when swapping is involved.

I have a ramfs mounted as /tmp. When I create a large file:

    dd if=/dev/zero of=/tmp/xxx bs=1024K count=200
    
(with 128M RAM), the complete system comes to a halt. Hitting keys does not do 
anything anymore, console switching still works, but all other processes come 
to a halt as well. SysRq still works and by doing a 'saK', I can kill the dd 
process - afterwards, everything is fine again.

Same thing anytime I write large amounts of data to the ramfs.

Now today I even had that problem without writing anything to /tmp: running a 
compilation that creates one process sized ~100M, suddenly everything froze the 
same way as described above. Later a unmounted the ramfs and everything worked 
fine.

B.t.w.: Apart from this bug, ramfs really is a great thing. Mounting it to /tmp 
speeds up a number of tasks significantly! (p.e. browsing into archives with 
mc, which uses temporary files heavily.) IMO, that method should be propagated 
much more!

Ciao,
Nobbi

-- 
-- ______________________________________________________
-- JESUS CHRIST IS LORD!
--          To Him, even that machine here has to obey...
--
-- _________________________________Norbert "Nobbi" Nemec
-- Hindenburgstr. 44  ...  D-91054 Erlangen  ...  Germany
-- eMail: <nobbi@cheerful.com>   Tel: +49-(0)-9131-204180
