Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287333AbSASU7a>; Sat, 19 Jan 2002 15:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287337AbSASU7U>; Sat, 19 Jan 2002 15:59:20 -0500
Received: from 213-98-126-44.uc.nombres.ttd.es ([213.98.126.44]:64189 "HELO
	mitica.trasno.org") by vger.kernel.org with SMTP id <S287333AbSASU7J>;
	Sat, 19 Jan 2002 15:59:09 -0500
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removing files in devfs
In-Reply-To: <20020119094424.A239@gmxpro.net>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20020119094424.A239@gmxpro.net>
Date: 19 Jan 2002 21:54:57 +0100
Message-ID: <m21ygmxdr2.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "oliver" == Oliver Feiler <kiza@gmx.net> writes:

oliver> Hello,
oliver> Is this behaviour supposed to be?

oliver> 9:36 root@kiza /dev# l null 
oliver> crw-rw-rw-    1 root     root       1,   3 Jan  1  1970 null
oliver> 9:36 root@kiza /dev# rm null
oliver> removing `null'
oliver> 9:36 root@kiza /dev# l null
oliver> ls: null: No such file or directory
oliver> 9:36 root@kiza /dev#

oliver> I have kernel 2.4.16 with devfs and on every other system I tried I 
oliver> only get "rm: cannot unlink `null': Operation not permitted" when trying to 
oliver> delete something in devfs. And I cannot see any differences as far as devfs is 
oliver> concerned on the systems I tried. devfs compiled in, mounted on boot time, 
oliver> same version of devfsd.

oliver> Regards,

oliver> Oliver

Since 2.4.16-preX, you can't remove a {file,symlink} in devfs created
by devfs :(

That hit me hardly whith /dev/root.  I had to remove the code that
generate that link to get my system booting (where system is anything
booting with mkinitrd + devfs).

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
