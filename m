Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132082AbQKXIkR>; Fri, 24 Nov 2000 03:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132211AbQKXIkI>; Fri, 24 Nov 2000 03:40:08 -0500
Received: from [200.222.191.209] ([200.222.191.209]:32772 "EHLO
        pervalidus.dyndns.org") by vger.kernel.org with ESMTP
        id <S132082AbQKXIkC>; Fri, 24 Nov 2000 03:40:02 -0500
Date: Fri, 24 Nov 2000 06:09:42 -0200
From: Frédéric L . W . Meunier 
        <0@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.2-51 is buggy
Message-ID: <20001124060942.B26543@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Mailer: Mutt/1.2.5i - Linux 2.2.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

<skip>
> % /usr/gcc/aeb/bin/gcc -v
> Reading specs from
> /usr/gcc/aeb/lib/gcc-lib/i686-pc-linux-gnu/2.95.2/specs
> gcc version 2.95.2 19991024 (release)gcc version 2.95.2 19991024 (release)
> % /usr/gcc/aeb/bin/gcc -Wall -O2 -o nobug bug.c; ./nobug
> 0x0

Interesting. On a Slackware 7.1 recently upgraded to glibc 2.2
(and where gcc 2.95.2 from ftp.gnu.org was built because 2.2
requires this version) I get:

% gcc -Wall -O2 -o bug bug.c
% ./bug
0x84800000

% egcs-2.91.66 -Wall -O2 -o bug bug.c
% ./bug
0x0

% gcc -Wall -O -o bug bug.c
% ./bug
0x0

% gcc -v
Reading specs from
/usr/lib/gcc-lib/i386-slackware-linux/2.95.2/specs
gcc version 2.95.2 19991024 (release)

% egcs-2.91.66 -v
Reading specs from
/usr/lib/gcc-lib/i386-slackware-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

Slackware's -current tree was upgraded to glibc 2.2 and gcc
2.95.2, but I built them myself.

-- 
0@pervalidus.{net, com, dyndns.org}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
