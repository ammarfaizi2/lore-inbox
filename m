Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288976AbSAITpN>; Wed, 9 Jan 2002 14:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288978AbSAITpD>; Wed, 9 Jan 2002 14:45:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15489 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S288976AbSAITox>; Wed, 9 Jan 2002 14:44:53 -0500
Date: Wed, 9 Jan 2002 14:45:03 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sipos Ferenc <sferi@dumballah.tvnet.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: system time issue
In-Reply-To: <1010602407.6235.0.camel@zeus.city.tvnet.hu>
Message-ID: <Pine.LNX.3.95.1020109143029.8141A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1000706587-1010605503=:8141"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-1000706587-1010605503=:8141
Content-Type: TEXT/PLAIN; charset=US-ASCII

On 9 Jan 2002, Sipos Ferenc wrote:

> Hi!
> 
> I have a redhat 7.2 box, and compiled the latest 2.4.18pre2 kernel with
> the 2.4.18pre2aa1 patches in order to use gcc pre 3.1. When I shutdown
> my system with the new kernel, it writes out normally: syncing system
> time with hardware time, and with gcc 2.96 compiled kernels, everything
> is ok, but with this kernel, after reboot the bios beeps and the
> hardware time and date stands at the beginning, so I have to setup
> manually to continue the post process. I think, gcc pre3.1 miscompiles
> something in the kernel.
> 

Here is a test program I would like everybody to try. It is a module
but is not intended to actually be implimented in the kernel as a
module once eveybody finds out that it will reliably cold-start even
a SMP machine. This is for Intel CPUs only.

The purpose of the module is to execute two simple CPU instructions
in kernel mode. This forces a processor reset, just like hitting
the reset button.

There are two scripts that you should look at because you might
want to go to single-user mode first and unmount your disk(s)
if your `kill -1` command kills you as well as everybody else.

I think all the complex reboot stuff in the kernel can be removed
and the simple two-line assembly substituted.

If anybody finds that executing the 'open()' of this test module
does not cause a processor reset in which a cold boot is forced,
please let me know.

Once most everybody has faith that this will produce a clean
reboot, somebody, maybe Allan can use it to replace the reboot
code in the kernel.

The code works by disabling paging while executing code where
there is not a 1:1 physical/virtual page mapping. I have never
found a system, even one with two CPUs that did not instantly
reset.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


--1678434306-1000706587-1010605503=:8141
Content-Type: APPLICATION/octet-stream; name="reboot.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1020109144503.8141B@chaos.analogic.com>
Content-Description: 

H4sIADKaPDwAA+1YbVPbOBDmK/4VSzh6CZMQOyGhQ9qb6bTpHNdQZlJ6fCgd
V5FloosjeWQ5Idfhv9/Kdl6AAAdH6DH1MoMjrVa7ela70kqxnpS6urZKgl17
r9GANTBkX/lmDdjbdfYcp2E7DQDHrtfra9BYqVUZxZEmCmBNIQy3jbuL/0xJ
pf5XzMCgd+gqdDi23dzdvdH/jYZdT/zfbOKweg39X6vtNdfAXoUxV+kn97+1
yX3hMR9c90O7+7HdcV1rE9tcsEtdTHjct2ajD4/efe60ZyOnzXTUXP5d9+DP
dtfIc0GD2GPwKuAiPq8OmBIs2On/do0zlF4csKUcEgSSLuP40bJeLri+3E+i
YTUmlLIous7g0vRZ1e3K68f6267idBZsA7yPBdVcCgiV1FJPQhbtIKNq4e7T
nAIXGjw24pS5MmSiGGkVU43dEs3bLkPW9nmAzVILlsjRQEbsbkEj4boGGzD/
3BTv4khyr9SyzAdowIiIwyusx0ZmugQqRaSB9jEKcSVfvr4uZMmo0Jrvrzd/
gPPy5Qq8A4l74L3BB5FXJPFSilqsmLFOEy4i6JEIjfUzP0agZTaeAclcsOjQ
Bdzd2bzR1Fe+DCN4Dd9NPEG6Rq94/PvBJzeNpJJlEuNCRzmLLUgYHz93OmW4
jXBhQRAxNkibaNe/llOMeNPmfeTGiiMWD9PncXVvuVAGwUPs5JLqqeB95IZD
El7RtxCxN4ijnOE+xE4/iKP+Un1JpC+XR7mEe1nOLsPF4wdwltqOzPp0n2XW
3SOtcRFeSVB+WLK+Jya7LuZk18XvSAY4F4aRC0UoDOUogF+cMmwxcn4qIGmb
39hDlX0qCpiqzASKYfwKsFsJKCccN4tgI6agT0JjMRp5ASuC5G3igrsxWZay
bwNltqbVmQ4HeChwEvC/Ma8JD1We8UgjbGY16YGQLOaGY2RqqWFjGo8DnXqD
+8Vi2sa0N53TpX2FSBQxu5cNJGV4sZAfSyV4BXaaCdNJDYUKpx4UzcXEfdNp
d4+h8JaIX/Xc0C3M1RMYkr+kAhEPe6bLw32RqUBl2Q5ZQHTR1IurUK8K6S7D
czbbJwvILjuCl8F6HddY3ITsPbGcTwSnha3otADFLa80xzDVeA3GKX4rQOz/
PN2PvsL/J8rqv0MyYCbbrETHHfUf1J3arP6rN/dM/Wc38/rvSciysKraX1+f
PgBIzEvtT8eWZc169mdMaq2vn1EKlaMaVE5QECrYkDAXno+0zDQLExtZvL9u
wBeokEQHfIWWSX4CTpGH+2A4wCMwZVFz3cc90kp4PresJCPuY0MNoeIvqMzM
fd5h+MNo9v7TW93+xvi//f2v7sziv9kw8e80a3n8PwltblR7XFSxuu1bm5Yn
ud7BquNFHk4/CWXxnzl+NTruiv9dZE7jv+Ek8b9Xd/L4fwq6FP9wQpTg4gwL
UDlkgNVylLxaSR8GpoD2pKkOxlINgEqlGNXBJKkS8RSfoHgyyJQz7JzRWONM
5r3TPLduYF2JIyeAJbjQ5WyAqX14BCRC2W+z3PPNvK15fCQVZeArOUymDIlC
SRj3Oe3D2Cg6Yxp6gRwLlAYyJmgBlqURlkzz24EVTQS1Ersqx+3uIVScxa4P
B53OrCseyhg1VIgVjUkofd/8pERj6ZTcSfKcmFNOOeWUU0455ZRTTjk9a/oH
y5UD7QAoAAA=
--1678434306-1000706587-1010605503=:8141--
