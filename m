Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284023AbRLAJcw>; Sat, 1 Dec 2001 04:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284021AbRLAJcn>; Sat, 1 Dec 2001 04:32:43 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:26642 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284024AbRLAJce>; Sat, 1 Dec 2001 04:32:34 -0500
Message-ID: <3C08A387.90303@namesys.com>
Date: Sat, 01 Dec 2001 12:31:51 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nikita Danilov <Nikita@namesys.com>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Block I/O Enchancements, 2.5.1-pre2
In-Reply-To: <Pine.LNX.4.33.0111271933100.1195-100000@penguin.transmeta.com>	<E169dGg-0000iO-00@starship.berlin>	<3C0779BD.7090604@namesys.com> <15367.32910.275973.287742@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Hans Reiser writes:
>
>
>Having 64 bit inode numbers is good, but we *can* live without them:
>currently inode hash table can store inodes with identical inode
>numbers, provided they can be distinguished by find_actor. Inode numbers
>are just first fast guess during table scan, if they coincide,
>find_actor is used.
>

Nikita is entirely correct, 32 bits of inode number hash is plenty.

64k blocks remain a solution whose potential drain on memory bandwidth 
worries me.

Hans



