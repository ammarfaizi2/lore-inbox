Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131987AbRANQtj>; Sun, 14 Jan 2001 11:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132002AbRANQt3>; Sun, 14 Jan 2001 11:49:29 -0500
Received: from hercules.telenet-ops.be ([195.130.132.33]:31494 "HELO
	smtp.pandora.be") by vger.kernel.org with SMTP id <S131987AbRANQtN>;
	Sun, 14 Jan 2001 11:49:13 -0500
Date: Sun, 14 Jan 2001 17:59:39 +0100
From: Ben De Rydt <ben.de.rydt@pandora.be>
To: linux-kernel@vger.kernel.org
Subject: /proc/*/mem permissions (2.2.19pre6)
Message-ID: <20010114175939.A1649@nosfer.co.and.co>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

/proc/*/mem/ permissions default to -rw------- root root

[2.] Full description of the problem/report:

$ uname -r
2.2.19pre6
$ ps 
  PID TTY          TIME CMD
 1646 pts/2    00:00:00 bash2
 1649 pts/2    00:00:00 mutt
 1703 pts/2    00:00:00 vim
 1753 pts/2    00:00:00 bash2
 1754 pts/2    00:00:00 ps
$ ls -l /proc/1703/mem
-rw-------    1 root     root            0 Jan 14 17:52 /proc/1703/mem

$ uname -r 
2.2.13
$ ps 
  PID TTY          TIME CMD
18489 pts/0    00:00:00 bash
18512 pts/0    00:00:00 ps
$ ls -l /proc/18489/mem 
-rw-------   1 ben      users           0 Jan 14 18:04 /proc/18489/mem

This makes the leak-detection algoritm of memprof (and possibly other
programs) fail. 

Greetings,
-- 
ben . de . rydt at pandora . be ------------------ your comments
http://users.pandora.be/bdr/ ------- inl. IPv6, Linux en Pandora

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
