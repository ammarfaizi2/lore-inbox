Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316053AbSETOYL>; Mon, 20 May 2002 10:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316056AbSETOYK>; Mon, 20 May 2002 10:24:10 -0400
Received: from 213-98-127-214.uc.nombres.ttd.es ([213.98.127.214]:58560 "EHLO
	demo.mitica") by vger.kernel.org with ESMTP id <S316053AbSETOYJ>;
	Mon, 20 May 2002 10:24:09 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: mfedyk@matchmail.com (Mike Fedyk), Wayne.Brown@altec.com,
        linux-kernel@vger.kernel.org, kaos@ocs.com.au (Keith Owens)
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
In-Reply-To: <200205200509.g4K59a9494917@saturn.cs.uml.edu>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 20 May 2002 16:29:36 +0200
Message-ID: <m2y9eex57z.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "albert" == Albert D Cahalan <acahalan@cs.uml.edu> writes:

albert> Mike Fedyk writes:
>> On Sat, May 18, 2002 at 12:32:25PM -0500, Wayne.Brown@altec.com wrote:

>>> I never expected everyone to abandon their own needs to satisfy mine.
>>> It would be nice if they tried to accomodate my needs while satisfying
>>> their own, but I didn't expect that either.  
>> 
>> IIRC, Kbuild-2.5 already silently accepts all of the old kbuild-2.4
>> commands without problems.
>> 
>> As long as you end up running "make install" the rest of the old commands
>> will be ignored.  You can go on with all of the old commands, if you want
>> without any trouble.

albert> Well, not everybody trusts "make install" to do something useful.
albert> I'd do something like this:

albert> make clean
albert> bzip2 -dc ../foo.bz2 | patch -E -s -p1

albert> make menuconfig
albert> time script build-log
albert> make vmlinux && make modules && make modules_install && exit

this is standard

albert> cp vmlinux /boot/vmlinux-2.5.16
albert> cp System.map /boot/System.map-2.5.16
albert> cp .config /boot/config-2.5.16
albert> sync
albert> su -
albert> joe /etc/yaboot.conf
albert> sync
albert> exit

You can put that thing in /sbin/install and actual build system will
do what you want.  Here we modify grub || lilo in x86 in that script,
it is not difficult to automatize.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
