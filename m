Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUGEUXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUGEUXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 16:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUGEUXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 16:23:11 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:51330 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261610AbUGEUWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 16:22:51 -0400
Message-ID: <40E9B8D0.10508@blue-labs.org>
Date: Mon, 05 Jul 2004 16:23:44 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040705
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: segfaults and sockets
Content-Type: multipart/mixed;
 boundary="------------070808040701030407060600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070808040701030407060600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kernel 2.6.7, vanilla.

This pops up on dmesg when I try to run tcptraceroute.  Would someone 
kindly explain why this is being reported in kernel messages?  I'm 
assuming that this is a bug in tcptraceroute not being truly sensible of 
the fact that I use nameif to rename my interfaces.

tcptraceroute[2148]: segfault at 000012500050f6d0 rip 0000002a957f79ec 
rsp 0000007fbffff020 error 6

#define ENXIO            6      /* No such device or address */


write(2, "Selected device cable, address 24.250.19.246", 44Selected 
device cable, address 24.250.19.246) = 44
write(2, ", port 35611", 12, port 35611)            = 12
write(2, " for outgoing packets\n", 22 for outgoing packets
) = 22
socket(PF_PACKET, SOCK_RAW, 768)        = 5
ioctl(5, 0x8933, 0x7fbffff420)          = 0
ioctl(5, 0x8927, 0x7fbffff420)          = 0
ioctl(5, 0x8933, 0x7fbffff420)          = 0
bind(5, {sa_family=AF_PACKET, proto=0x03, if1, pkttype=PACKET_HOST, 
addr(0)={0, }, 20) = 0
getsockopt(5, SOL_SOCKET, SO_ERROR, "\0\0\0\0", [216172855128227844]) = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 6
ioctl(6, 0x8915, 0x7fbffff630)          = 0
ioctl(6, 0x891b, 0x7fbffff630)          = 0
close(6)                                = 0
setsockopt(5, SOL_SOCKET, 0x1a /* SO_??? */, 
"\1\0\0\0\0\0\0\0\260\270x\225*\0\0\0", 16) = 0
fcntl(5, F_GETFL)                       = 0x2 (flags O_RDWR|O_LARGEFILE)
fcntl(5, F_SETFL, O_RDWR|O_NONBLOCK)    = 0
recvfrom(5, 0x7fbffff62f, 1, 32, 0, 0)  = -1 EAGAIN (Resource 
temporarily unavailable)
fcntl(5, F_SETFL, O_RDWR)               = 0
setsockopt(5, SOL_SOCKET, 0x1a /* SO_??? */, 
"\27\0P\0\0\0\0\0\0\370P\0\0\0\0\0", 16) = 0
fcntl(5, F_SETFL, O_RDONLY|O_NONBLOCK)  = 0
getuid()                                = 0
setuid(0)                               = 0
write(2, "Tracing the path to slashdot.org (66.35.250.150) on TCP port 
80, 30 hops max", 76Tracing the path to slashdot.org (66.35.250.150) on 
TCP port 80, 30 hops max) = 76
write(2, "\n", 1
)                       = 1
sendto(4, 
"E\0\0(]\364\0\0\1\6\0\0\30\372\23\366B#\372\226\213\33\0P\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 
40, 0, {sa_family=AF_INET, sin_port=htons(0), 
sin_addr=inet_addr("66.35.250.150")}, 16) = 40
select(6, [5], NULL, NULL, {3, 0})      = 1 (in [5], left {2, 980000})
recvfrom(5, 
"\0\16\246c\363\202\0\6*\313,p\10\0E\300\0008UM\0\0\377\1\306\302\n\4h\1\30\372\23\366\v\0i\224\0\0\0\0E\0\0(]\364\0\0\1\6\3622\30\372\23\366B#\372\226\213\33\0P\0\0\0\0", 
106, MSG_TRUNC, {sa_family=AF_PACKET, proto=0x800, if1, 
pkttype=PACKET_HOST, addr(6)={1, 00062acb2c70}, [20]) = 70
ioctl(5, 0x8906, 0x7fbfffeff0)          = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++



--------------070808040701030407060600
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------070808040701030407060600--
