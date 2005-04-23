Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVDWUhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVDWUhx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVDWUhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 16:37:53 -0400
Received: from smtpout.mac.com ([17.250.248.46]:60645 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261783AbVDWUhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 16:37:45 -0400
In-Reply-To: <20050423191213.GA505@DervishD>
References: <4ae3c14050417085473bd365f@mail.gmail.com> <Pine.LNX.4.62.0504230947070.23658@twinlark.arctic.org> <4a5cc1ac18788e708f9a5f3a5bd31be0@mac.com> <20050423191213.GA505@DervishD>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ba1e71adc21a7b85ac989786540aee87@mac.com>
Content-Transfer-Encoding: 7bit
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Why Ext2/3 needs immutable attribute?
Date: Sat, 23 Apr 2005 16:37:34 -0400
To: DervishD <lkml@dervishd.net>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 23, 2005, at 15:12, DervishD wrote:
>  * Kyle Moffett <mrmacman_g4@mac.com> dixit:
>>> another usage:  if you "chattr +i /var" while /var is unmounted,
>>> then root is unlikely to accidentally create files/dirs in /var --
>>> and when you mount the real /var on top it works fine.  i tend to
>>> protect all my mount points this way (especially those in /mnt) to
>>> avoid my own dumb mistakes.
>> If you chmod 000 /var beforehand (While it's still unmounted, of
>> course), then it's also blindingly obvious that it's not mounted in
>> an ls -l :-D. I too have used this trick on many/most of my
>> systems.
> I was doing exactly that, but it has its drawbacks: root still
> can create files by accident. [...]

Ah, I meant in combination with the above trick:

# umount /var
# chmod 000 /var
# chattr +i /var
# ls -alhd /var
d---------    2 root     root       68 Apr 23 16:36 /var
# mount /var

If I forget to mount var, not only can I not create files, I'll also
notice when I "ls -alh /".

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


