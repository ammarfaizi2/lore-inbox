Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131587AbRDPQrJ>; Mon, 16 Apr 2001 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131590AbRDPQq7>; Mon, 16 Apr 2001 12:46:59 -0400
Received: from argus.posten.se ([147.14.10.164]:46282 "HELO argus.posten.se")
	by vger.kernel.org with SMTP id <S131587AbRDPQqp> convert rfc822-to-8bit;
	Mon, 16 Apr 2001 12:46:45 -0400
From: "Pawel Worach, Posten" <pawel.worach@posten.se>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Date: Mon, 16 Apr 2001 19:46 +0200
Message-id: <200104161746.n70O@memo.posten.se>
Subject: Abit BP6 hang on reboot
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Received from DGA.PAWO002 08 - 781 3387        01-04-16 18.46

Hi folks!

I'm using a Abit BP6 mobo with dual Celeron CPU's (no OC),
somewhere in the 2.4.3-ac3-7 kernels the box hangs totally (not
even the reset button works!) when it resets (after
'init 6' for example).

Any ideas? (hardware problem?)


Oh and another thing... (2.4.3-ac6-7 & maybe others) playing
around with this ipv6 protocol I found this strange problem.
Everything (apache, bind etc.) is vorking except icmp to
nonlocalhost addresses.

root@darkstar ~# ifconfig eth0 | grep inet6
          inet6 addr: fe80::290:27ff:fe76:b0c1/10 Scope:Link
root@darkstar ~# ping6 fe80::290:27ff:fe76:b0c1
connect: Invalid argument
root@darkstar ~# ping6 ::1
PING ::1(::1) from ::1 : 56 data bytes
64 bytes from ::1: icmp_seq=0 hops=64 time=92 usec
64 bytes from ::1: icmp_seq=1 hops=64 time=42 usec

Updated to the net-tools and stuff from latest RawHide and still
it says "invalid argument".

strace output:
socket(PF_INET6, SOCK_RAW, 58)          = 3
getuid32()                              = 0
setuid32(0)                             = 0
socket(PF_INET6, SOCK_DGRAM, 0)         = 4
connect(4, {sin_family=AF_INET6, sin6_port=htons(1025),
inet_pton(AF_INET6, "fe80::290:27ff:fe76:b0c1", &sin6_addr),
sin6_flowinfo=htonl(0)}}, 28) = -1 EINVAL (Invalid argument)

Anyone?

dd if=/dev/urandom of=/dev/audio
Regards Pawel Worach
PostGirot Bank AB

---- 01-04-16 18.46 ---- Sent to       ---------------------------
  -> linux-kernel(a)vger.kernel.org
