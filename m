Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbRFYSAL>; Mon, 25 Jun 2001 14:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265891AbRFYSAB>; Mon, 25 Jun 2001 14:00:01 -0400
Received: from w244.z064001166.sjc-ca.dsl.cnc.net ([64.1.166.244]:57934 "HELO
	hellmouth.digitalvampire.org") by vger.kernel.org with SMTP
	id <S265894AbRFYR7s>; Mon, 25 Jun 2001 13:59:48 -0400
To: linux-kernel@vger.kernel.org
Subject: Linux and system area networks
From: Roland Dreier <roland@hellmouth.digitalvampire.org>
Date: 25 Jun 2001 10:59:27 -0700
Message-ID: <87vglkxwxs.fsf@love-shack.i-did-not-set--mail-host-address--so-shoot-me>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to find out if anyone has thought about how Linux will handle
some of the new network technologies people are starting to push.
Specifically I'm talking about "System Area Networks," that is, things
like Infiniband, as well as TCP/IP offload.

In the past people have advocated VIA as a way to use network hardware
that provides reliability and remote DMA (RDMA).  However, VI never
really caught on because it requires applications to be completely
rewritten.  In addition, the corporate backers of VI seem to have
mostly given up on it.

Late last year, Network Appliance proposed something they called
"DASockets," which would mostly preserve socket semantics.  However
that seems to have been put on hold.

Microsoft recently introduced something called "Winsock Direct" in W2K
Datacenter.  For more info you can look at:

http://www.microsoft.com/windows2000/en/datacenter/help/default.asp?url=/WINDOWS2000/en/datacenter/help/WSD_and_SAN.htm

The rough idea is that WSD is a new user space library that looks at
sockets calls and decides if they have to go through the usual kernel
network stack, or if they can be handed off to a "SAN service
provider" which bypasses the network stack and uses hardware reliable
transport and possibly RDMA.

This means that all applications that use Winsock benefit from the
advanced network hardware.  Also, it means that Windows is much easier
for hardware vendors to support than other OSes.  For example,
Alacritech's TCP/IP offload NIC only works under Windows.  Microsoft
is also including Infiniband support in Windows XP and Windows 2002.
(Intel will be pushing Infiniband onto motherboards pretty soon, which
will bring reliable transport, RDMA network hardware into the
mainstream)

So I guess my question is whether anyone has started thinking about
the architectural changes needed to make System Area Networking and
TCP/IP offload easier under Linux.

Thanks,
  Roland
-- 
Roland Dreier                                <roland@digitalvampire.org>
GPG Key fingerprint = A89F B5E9 C185 F34D BD50  4009 37E2 25CC E0EE FAC0
