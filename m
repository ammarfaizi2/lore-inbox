Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129325AbQKXRRI>; Fri, 24 Nov 2000 12:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129428AbQKXRQ6>; Fri, 24 Nov 2000 12:16:58 -0500
Received: from cm698210-a.denton1.tx.home.com ([24.17.129.59]:58123 "HELO
        cm698210-a.denton1.tx.home.com") by vger.kernel.org with SMTP
        id <S129325AbQKXRQw>; Fri, 24 Nov 2000 12:16:52 -0500
Message-ID: <3A1E9B74.A0FDE03E@home.com>
Date: Fri, 24 Nov 2000 10:46:44 -0600
From: Matthew Vanecek <linux4us@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.2-51 is buggy
In-Reply-To: <UTC200011241248.NAA138093.aeb@aak.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> > so the reason why it did not show up in the gcc you picked up from
> > ftp.gnu.org is that you have compiled it so that it defaults to -mcpu=i686
> 
> Yes, you are right.
> 
> So 2.95.2 fails for i386, i486, i586 and does not fail for i686.
> 

RedHat 7.0's gcc 2.96 and kgcc do not seem to exhibit this problem:

me2v@reliant tmp $ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.0)
me2v@reliant tmp $ kgcc -v
Reading specs from
/usr/lib/gcc-lib/i386-glibc21-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
me2v@reliant tmp $ gcc -O2 -o bug bug.c ; ./bug
0x0
me2v@reliant tmp $ gcc -o bug bug.c ; ./bug
0x0
me2v@reliant tmp $ kgcc -O2 -o bug bug.c ; ./bug
0x0
me2v@reliant tmp $ kgcc -o bug bug.c ; ./bug
0x0

-- 
Matthew Vanecek
perl -e 'print
$i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
********************************************************************************
For 93 million miles, there is nothing between the sun and my shadow
except me.
I'm always getting in the way of something...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
