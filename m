Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292380AbSB0U1m>; Wed, 27 Feb 2002 15:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292937AbSB0U1R>; Wed, 27 Feb 2002 15:27:17 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:7428 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S292935AbSB0U0f>; Wed, 27 Feb 2002 15:26:35 -0500
Date: Wed, 27 Feb 2002 20:26:22 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Joe <joeja@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.18 and RH 7.2
Message-ID: <20020227202622.A25404@flint.arm.linux.org.uk>
In-Reply-To: <3C7D24F9.B93D47E6@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7D24F9.B93D47E6@mindspring.com>; from joeja@mindspring.com on Wed, Feb 27, 2002 at 10:27:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 10:27:05AM -0800, Joe wrote:
> Not sure if this has been reported as I am not on the mailing list.  I'm
> guessing probably yes.
> 
> I have a RH 7.2 box and am getting the following error from iptables and
> kernel 2.4.18. I don't get it in 2.4.17.
> 
> output from /etc/init.d/iptables start
> 
> Flushing all current rules and user defined chains:        [  OK  ]
> Clearing all current rules and user defined chains:        [  OK  ]
> iptables: libiptc/libip4tc.c:384: do_check: Assertion
> `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> /etc/init.d/iptables: line -242:  1222 Aborted                 iptables
> -t $i -Fiptables: libiptc/libip4tc.c:384: do_check: Assertion
> `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> /etc/init.d/iptables: line -239:  1225 Aborted                 iptables
> -t $i -Xiptables: libiptc/libip4tc.c:384: do_check: Assertion
> `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> /etc/init.d/iptables: line -235:  1228 Aborted                 iptables
> -t $i -ZApplying iptables firewall rules:
> iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
> `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> /etc/init.d/iptables: line -232:  1230 Done                    grep -v
> "^[[:space:]]*#" $IPTABLES_CONFIG
>       1231                       | grep -v '^[[:space:]]*$'
>       1232 Aborted                 | /sbin/iptables-restore -c

I'll add a "me too" to this - 2.4.18, iptables 1.2.4

Setting up IPv4 mangle rules:
iptables: libiptc/libip4tc.c:384: do_check: Assertion `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
/etc/fw-ipv4/mangle: line 2:   215 Aborted                 iptables -t mangle -F
iptables: libiptc/libip4tc.c:384: do_check: Assertion `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
/etc/fw-ipv4/mangle: line 3:   216 Aborted                 iptables -t mangle -X
iptables: libiptc/libip4tc.c:384: do_check: Assertion `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
/etc/fw-ipv4/mangle: line 15:   217 Aborted                 iptables -t mangle -A PREROUTING -i eth0 -d xxx.xxx.xxx.xxx/xx -j ACCEPT
... lots more ...

The rules do appear to be in the kernel however.

iptables 1.2.4 was rebuild for the 2.4.17 because it stopped working at
that point.  I hope it isn't requirement to rebuild iptables against each
stable kernel release.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

