Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129907AbRBOUyx>; Thu, 15 Feb 2001 15:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130031AbRBOUyo>; Thu, 15 Feb 2001 15:54:44 -0500
Received: from foobar.napster.com ([64.124.41.10]:25867 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S129907AbRBOUyg>; Thu, 15 Feb 2001 15:54:36 -0500
Message-ID: <3A8C4202.83C197D6@napster.com>
Date: Thu, 15 Feb 2001 12:54:26 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Jones <raj@cup.hp.com>
CC: kuznet@ms2.inr.ac.ru, roger@kea.GRace.CRi.NZ, linux-kernel@vger.kernel.org
Subject: Re: MTU and 2.4.x kernel
In-Reply-To: <200102151821.VAA19711@ms2.inr.ac.ru> <3A8C3EB5.BAB148B0@cup.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Jones wrote:
> 
> > Default of 536 is sadistic (and apaprently will be changed eventually
> > to stop tears of poor people whose providers not only supply them
> > with bogus mtu values sort of 552 or even 296, but also jailed them
> > to some proxy or masquearding domain), but it is still right: IP
> > with mtu lower 576 is not full functional.
> 
> I thought that the specs said that 576 was the "minimum maximum"
> reassemblable IP datagram size and not a minimum MTU.

RFC 1191 (Path MTU Discovery as it happens):

 
   Plateau    MTU    Comments                      Reference
   ------     ---    --------                      ---------
              65535  Official maximum MTU          RFC 791
              65535  Hyperchannel                  RFC 1044
   65535
   32000             Just in case
              17914  16Mb IBM Token Ring           ref. [6]
   17914
              8166   IEEE 802.4                    RFC 1042
   8166
              4464   IEEE 802.5 (4Mb max)          RFC 1042
              4352   FDDI (Revised)                RFC 1188
   4352 (1%)
              2048   Wideband Network              RFC 907
              2002   IEEE 802.5 (4Mb recommended)  RFC 1042
   2002 (2%)
              1536   Exp. Ethernet Nets            RFC 895
              1500   Ethernet Networks             RFC 894
              1500   Point-to-Point (default)      RFC 1134
              1492   IEEE 802.3                    RFC 1042
   1492 (3%)
              1006   SLIP                          RFC 1055
              1006   ARPANET                       BBN 1822
   1006
              576    X.25 Networks                 RFC 877
              544    DEC IP Portal                 ref. [10]
              512    NETBIOS                       RFC 1088
              508    IEEE 802/Source-Rt Bridge     RFC 1042
              508    ARCNET                        RFC 1051
   508 (13%)
              296    Point-to-Point (low delay)    RFC 1144
   296
   68                Official minimum MTU          RFC 791
 

Jordan
