Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281977AbRKUUyN>; Wed, 21 Nov 2001 15:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281978AbRKUUyD>; Wed, 21 Nov 2001 15:54:03 -0500
Received: from [168.159.129.100] ([168.159.129.100]:49416 "EHLO
	mxic1.isus.emc.com") by vger.kernel.org with ESMTP
	id <S281977AbRKUUx5>; Wed, 21 Nov 2001 15:53:57 -0500
Message-ID: <93F527C91A6ED411AFE10050040665D00241AB03@corpusmx1.us.dg.com>
From: berthiaume_wayne@emc.com
To: linux-kernel@vger.kernel.org
Subject: Multicast Broadcast
Date: Wed, 21 Nov 2001 15:53:48 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C172CE.9E0E47D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C172CE.9E0E47D0
Content-Type: text/plain;
	charset="iso-8859-1"

	Hello group....

	I have a cluster that I wish to be able to perform a multicast
broadcast over two backbones, primary and secondary, simultaneously. The two
eth's are bound to the same VIP. When I perform the broadcast, it only goes
out on eth0. 
	Is there a way to do this without writing an application to do it?
I've been looking at igmp.c:ip_mc_join_group to do a possible change like:

#ifdef DUAL_MCAST_BIND
   if(!imr->imr_ifindex) {
      imr->ifindex=2;  /* eth0 */
      err=ip_mc_join_group(sk, imr);
      if (!err) {
        imr->ifindex=3; /* eth1 */
        err=ip_mc_join_group(sk, imr);
      }
      return err;
   }
#else
   if(!imr->imr_ifindex)
     in_dev = ip_mc_find_dev(imr);
#endif

	Will this be necessary??? Could there be something in the kerenl to
configure?

PS: Please cc me any response as I'm not yet monitoring this group.

Thanks,
Wayne
EMC Corp
ObjectStorEngineering
4400 Computer Drive
M/S F213
Westboro,  MA    01580

email:       Berthiaume_Wayne@emc.com
                 WBerthiaume@clariion.com

"One man can make a difference, and every man should try."  - JFK







------_=_NextPart_000_01C172CE.9E0E47D0
Content-Type: application/octet-stream;
	name="Wayne Berthiaume (E-mail).vcf"
Content-Disposition: attachment;
	filename="Wayne Berthiaume (E-mail).vcf"

BEGIN:VCARD
VERSION:2.1
N:Berthiaume;Wayne
FN:Wayne Berthiaume
ORG:EMC Corp
TITLE:Sr Attach Engineer
TEL;WORK;VOICE:(508) 382-6026
TEL;PAGER;VOICE:(888) 769-4578
TEL;WORK;FAX:(508) 480-7897
ADR;WORK;ENCODING=QUOTED-PRINTABLE:;;CLARiiON Attach Engineering=0D=0A4 Coslin Drive=0D=0AM/S C4-40;Southboro;M=
A;01772;United States of America
LABEL;WORK;ENCODING=QUOTED-PRINTABLE:CLARiiON Attach Engineering=0D=0A4 Coslin Drive=0D=0AM/S C4-40=0D=0ASouthbor=
o, MA 01772=0D=0AUnited States of America
URL;WORK:http://www.emc.com
REV:20010108T191730Z
END:VCARD

------_=_NextPart_000_01C172CE.9E0E47D0--
