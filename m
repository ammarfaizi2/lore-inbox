Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282714AbRK0B0U>; Mon, 26 Nov 2001 20:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282715AbRK0B0I>; Mon, 26 Nov 2001 20:26:08 -0500
Received: from A6f51.pppool.de ([213.6.111.81]:7944 "EHLO fireserver.worker")
	by vger.kernel.org with ESMTP id <S282714AbRK0BZ7>;
	Mon, 26 Nov 2001 20:25:59 -0500
Message-ID: <XFMail.20011127022542.ralf.hoffmann@epost.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.5.1.Linux:20011127022541:923=_"
Date: Tue, 27 Nov 2001 02:25:42 +0100 (CET)
From: Ralf Hoffmann <ralf.hoffmann@epost.de>
To: linux-kernel@vger.kernel.org
Subject: network stall for kernel 2.2.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.5.1.Linux:20011127022541:923=_
Content-Type: text/plain; charset=iso-8859-1

Hi,

This is my first post to this list and I'm unsure if this is the right place
for my problem but I have read the FAQ and searched the archive without any
result.

At home I have a gateway-machine running kernel 2.2.19 which connects with ppp
to the internet and masq my main machine running kernel 2.4.12.
All the masq and forwarding stuff works great for most of the time.

But while connected I sometimes get a network stall at the gateway. I cannot
load any page, I always get a timeout. This only affects the gateway, not my
client machine. While the gateway can't open any connection, everything works at
my client!
After a half hour (or so) without any action from me everything goes back to
normal so also the gateway can make connections again.

I made some tcpdumps which I have attached:

The first "client-out1" is from "tcpdump -i ppp0" when running
"lynx www.boomerangsworld.de" at the client machine.
The page load is successful.

The second "server-out1" show the ouput of tcpdump when trying to load the same
page at the server.

The third "server-out2" is the ouput when everything is normal at the server.

I can't really read the tcpdump-output but what I notice is the missing "ack"!

I think the forwarding/masq works in this situation so the client isn't
affected, but something is wrong at the server.

My configuration:
Server:
  Pentium200MMX
  Slackware 7
  Kernel 2.2.19
Client:
  PIII 800
  Slackware 7 modified for Kernel 2.4
  Kernel 2.4.12

Please ask for more information, I don't know what's important and what's not.

Upgrade to Kernel 2.4 at the server isn't a choice.

Perhaps this has nothing to do with the kernel network code, but any help is
welcome, this problem is really annoying.

And again, if this is the wrong place for my problem, please excuse me.

Thanks in advance,

Ralf Hoffmann

P.S.: Please CC to me because I'm not subscribed to the list.


--_=XFMail.1.5.1.Linux:20011127022541:923=_
Content-Disposition: attachment; filename="client-out1"
Content-Transfer-Encoding: base64
Content-Description: client-out1
Content-Type: application/octet-stream; name=client-out1; SizeOnDisk=1490

MjI6NTM6NTYuMzAxNTkyIDIxMy42LjIyMC43MS42MTAzNyA+IDIxMi4yMjcuMjIwLjkzLnd3dzog
UyA2NDM2MzIzNjk6NjQzNjMyMzY5KDApIHdpbiA1ODQwIDxtc3MgMTQ2MCxzYWNrT0ssdGltZXN0
YW1wIDE1MTkwODggMCxub3Asd3NjYWxlIDA+IChERikKMjI6NTM6NTYuNDY2MzQwIDIxMi4yMjcu
MjIwLjkzLnd3dyA+IDIxMy42LjIyMC43MS42MTAzNzogUyA2Mjg5NDExODk6NjI4OTQxMTg5KDAp
IGFjayA2NDM2MzIzNzAgd2luIDMyNzUyIDxtc3MgMTQ2MD4KMjI6NTM6NTYuNDc2ODM0IDIxMy42
LjIyMC43MS42MTAzNyA+IDIxMi4yMjcuMjIwLjkzLnd3dzogLiBhY2sgMSB3aW4gNTg0MCAoREYp
CjIyOjUzOjU2LjQ3ODE1MyAyMTMuNi4yMjAuNzEuNjEwMzcgPiAyMTIuMjI3LjIyMC45My53d3c6
IFAgMTo3NjMoNzYyKSBhY2sgMSB3aW4gNTg0MCAoREYpCjIyOjUzOjU2LjczNjI5MCAyMTIuMjI3
LjIyMC45My53d3cgPiAyMTMuNi4yMjAuNzEuNjEwMzc6IC4gYWNrIDc2MyB3aW4gMzI3NTIgKERG
KQoyMjo1Mzo1Ni44NzYyNzYgMjEyLjIyNy4yMjAuOTMud3d3ID4gMjEzLjYuMjIwLjcxLjYxMDM3
OiBQIDE6MjA2KDIwNSkgYWNrIDc2MyB3aW4gMzI3NTIgKERGKQoyMjo1Mzo1Ni44ODY5ODYgMjEz
LjYuMjIwLjcxLjYxMDM3ID4gMjEyLjIyNy4yMjAuOTMud3d3OiAuIGFjayAyMDYgd2luIDY0MzIg
KERGKQoyMjo1Mzo1Ny4xMTYyNzUgMjEyLjIyNy4yMjAuOTMud3d3ID4gMjEzLjYuMjIwLjcxLjYx
MDM3OiAuIDIwNjoxNjY2KDE0NjApIGFjayA3NjMgd2luIDMyNzUyIChERikKMjI6NTM6NTcuMTE4
MjU2IDIxMy42LjIyMC43MS42MTAzNyA+IDIxMi4yMjcuMjIwLjkzLnd3dzogLiBhY2sgMTY2NiB3
aW4gODc2MCAoREYpCjIyOjUzOjU3LjI5NjMxMCAyMTIuMjI3LjIyMC45My53d3cgPiAyMTMuNi4y
MjAuNzEuNjEwMzc6IC4gMTY2NjozMTI2KDE0NjApIGFjayA3NjMgd2luIDMyNzUyCjIyOjUzOjU3
LjI5ODMxNiAyMTMuNi4yMjAuNzEuNjEwMzcgPiAyMTIuMjI3LjIyMC45My53d3c6IC4gYWNrIDMx
MjYgd2luIDExNjgwIChERikKMjI6NTM6NTcuMzQ2MzE0IDIxMi4yMjcuMjIwLjkzLnd3dyA+IDIx
My42LjIyMC43MS42MTAzNzogUCAzMTI2OjM1NTgoNDMyKSBhY2sgNzYzIHdpbiAzMjc1MiAoREYp
CjIyOjUzOjU3LjM0NzM3NyAyMTMuNi4yMjAuNzEuNjEwMzcgPiAyMTIuMjI3LjIyMC45My53d3c6
IC4gYWNrIDM1NTggd2luIDE0NjAwIChERikKMjI6NTM6NTcuMzU2MzA1IDIxMi4yMjcuMjIwLjkz
Lnd3dyA+IDIxMy42LjIyMC43MS42MTAzNzogRiAzNTU4OjM1NTgoMCkgYWNrIDc2MyB3aW4gMzI3
NTIKMjI6NTM6NTcuMzY2OTkwIDIxMy42LjIyMC43MS42MTAzNyA+IDIxMi4yMjcuMjIwLjkzLnd3
dzogRiA3NjM6NzYzKDApIGFjayAzNTU5IHdpbiAxNDYwMCAoREYpCjIyOjUzOjU3LjUwNjM0OSAy
MTIuMjI3LjIyMC45My53d3cgPiAyMTMuNi4yMjAuNzEuNjEwMzc6IC4gYWNrIDc2NCB3aW4gMzI3
NTEgKERGKQo=

--_=XFMail.1.5.1.Linux:20011127022541:923=_
Content-Disposition: attachment; filename="server-out1"
Content-Transfer-Encoding: base64
Content-Description: server-out1
Content-Type: application/octet-stream; name=server-out1; SizeOnDisk=714

MjI6NTQ6MTYuMzExOTY0IDIxMy42LjIyMC43MS4yMDEzID4gMjEyLjIyNy4yMjAuOTMud3d3OiBT
IDU2NzA5MzAwOTo1NjcwOTMwMDkoMCkgd2luIDMyMTIwIDxtc3MgMTQ2MCxzYWNrT0ssdGltZXN0
YW1wIDE1MjQzMzggMCxub3Asd3NjYWxlIDA+IChERikKMjI6NTQ6MTYuNDY2MzQyIDIxMi4yMjcu
MjIwLjkzLnd3dyA+IDIxMy42LjIyMC43MS4yMDEzOiBTIDM0MTQ2MjE0MzI6MzQxNDYyMTQzMigw
KSBhY2sgNTY3MDkzMDEwIHdpbiAzMjc1MiA8bXNzIDE0NjA+CjIyOjU0OjE2LjQ3NjkyNSAyMTMu
Ni4yMjAuNzEuMjAxMyA+IDIxMi4yMjcuMjIwLjkzLnd3dzogUiA1NjcwOTMwMTA6NTY3MDkzMDEw
KDApIHdpbiAwIChERikKMjI6NTQ6MTkuMzA2MzY4IDIxMy42LjIyMC43MS4yMDEzID4gMjEyLjIy
Ny4yMjAuOTMud3d3OiBTIDU2NzA5MzAwOTo1NjcwOTMwMDkoMCkgd2luIDMyMTIwIDxtc3MgMTQ2
MCxzYWNrT0ssdGltZXN0YW1wIDE1MjQ2MzggMCxub3Asd3NjYWxlIDA+IChERikKMjI6NTQ6MTku
NTA2MzM0IDIxMi4yMjcuMjIwLjkzLnd3dyA+IDIxMy42LjIyMC43MS4yMDEzOiBTIDM0MTc2MTgz
OTI6MzQxNzYxODM5MigwKSBhY2sgNTY3MDkzMDEwIHdpbiAzMjc1MiA8bXNzIDE0NjA+CjIyOjU0
OjE5LjUxNjgxMyAyMTMuNi4yMjAuNzEuMjAxMyA+IDIxMi4yMjcuMjIwLjkzLnd3dzogUiA1Njcw
OTMwMTA6NTY3MDkzMDEwKDApIHdpbiAwIChERikK

--_=XFMail.1.5.1.Linux:20011127022541:923=_
Content-Disposition: attachment; filename="server-out2"
Content-Transfer-Encoding: base64
Content-Description: server-out2
Content-Type: application/octet-stream; name=server-out2; SizeOnDisk=1498

MDA6MjM6NTYuODEzMDU4IDIxMy42LjExNS4yNDIuMjAyNSA+IDIxMi4yMjcuMjIwLjkzLnd3dzog
UyAxOTQ2MTg5ODY3OjE5NDYxODk4NjcoMCkgd2luIDMyMTIwIDxtc3MgMTQ2MCxzYWNrT0ssdGlt
ZXN0YW1wIDIwNjIzODggMCxub3Asd3NjYWxlIDA+IChERikKMDA6MjM6NTYuOTU2MjczIDIxMi4y
MjcuMjIwLjkzLnd3dyA+IDIxMy42LjExNS4yNDIuMjAyNTogUyA0MTY5NDE3NTM6NDE2OTQxNzUz
KDApIGFjayAxOTQ2MTg5ODY4IHdpbiAzMjc1MiA8bXNzIDE0NjA+CjAwOjIzOjU2Ljk1NjQ4NiAy
MTMuNi4xMTUuMjQyLjIwMjUgPiAyMTIuMjI3LjIyMC45My53d3c6IC4gYWNrIDEgd2luIDMyMTIw
IChERikKMDA6MjM6NTYuOTU4MTk1IDIxMy42LjExNS4yNDIuMjAyNSA+IDIxMi4yMjcuMjIwLjkz
Lnd3dzogUCAxOjIwMSgyMDApIGFjayAxIHdpbiAzMjEyMCAoREYpCjAwOjIzOjU3LjE3NjMyOSAy
MTIuMjI3LjIyMC45My53d3cgPiAyMTMuNi4xMTUuMjQyLjIwMjU6IC4gYWNrIDIwMSB3aW4gMzI3
NTIgKERGKQowMDoyMzo1Ny4zOTYzMzQgMjEyLjIyNy4yMjAuOTMud3d3ID4gMjEzLjYuMTE1LjI0
Mi4yMDI1OiBQIDE6MjA2KDIwNSkgYWNrIDIwMSB3aW4gMzI3NTIgKERGKQowMDoyMzo1Ny4zOTY2
MTggMjEzLjYuMTE1LjI0Mi4yMDI1ID4gMjEyLjIyNy4yMjAuOTMud3d3OiAuIGFjayAyMDYgd2lu
IDMxOTE1IChERikKMDA6MjM6NTcuNjg2MzI4IDIxMi4yMjcuMjIwLjkzLnd3dyA+IDIxMy42LjEx
NS4yNDIuMjAyNTogLiAyMDY6MTY2NigxNDYwKSBhY2sgMjAxIHdpbiAzMjc1MiAoREYpCjAwOjIz
OjU3Ljg5NjMxMiAyMTIuMjI3LjIyMC45My53d3cgPiAyMTMuNi4xMTUuMjQyLjIwMjU6IC4gMTY2
NjozMTI2KDE0NjApIGFjayAyMDEgd2luIDMyNzUyCjAwOjIzOjU3Ljg5NjYwNiAyMTMuNi4xMTUu
MjQyLjIwMjUgPiAyMTIuMjI3LjIyMC45My53d3c6IC4gYWNrIDMxMjYgd2luIDMwNjYwIChERikK
MDA6MjM6NTcuOTU2Mjk2IDIxMi4yMjcuMjIwLjkzLnd3dyA+IDIxMy42LjExNS4yNDIuMjAyNTog
UCAzMTI2OjM1NTgoNDMyKSBhY2sgMjAxIHdpbiAzMjc1MiAoREYpCjAwOjIzOjU3Ljk3NjM1MiAy
MTMuNi4xMTUuMjQyLjIwMjUgPiAyMTIuMjI3LjIyMC45My53d3c6IC4gYWNrIDM1NTggd2luIDMy
MTIwIChERikKMDA6MjM6NTguMDE2MzUwIDIxMi4yMjcuMjIwLjkzLnd3dyA+IDIxMy42LjExNS4y
NDIuMjAyNTogRiAzNTU4OjM1NTgoMCkgYWNrIDIwMSB3aW4gMzI3NTIKMDA6MjM6NTguMDE2NjMx
IDIxMy42LjExNS4yNDIuMjAyNSA+IDIxMi4yMjcuMjIwLjkzLnd3dzogLiBhY2sgMzU1OSB3aW4g
MzIxMTkgKERGKQowMDoyMzo1OC4wMTc5MTQgMjEzLjYuMTE1LjI0Mi4yMDI1ID4gMjEyLjIyNy4y
MjAuOTMud3d3OiBGIDIwMToyMDEoMCkgYWNrIDM1NTkgd2luIDMyMTIwIChERikKMDA6MjM6NTgu
MTc2Mjk2IDIxMi4yMjcuMjIwLjkzLnd3dyA+IDIxMy42LjExNS4yNDIuMjAyNTogLiBhY2sgMjAy
IHdpbiAzMjc1MSAoREYpCg==

--_=XFMail.1.5.1.Linux:20011127022541:923=_--
End of MIME message
