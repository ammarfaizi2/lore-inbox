Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSIILGS>; Mon, 9 Sep 2002 07:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSIILGS>; Mon, 9 Sep 2002 07:06:18 -0400
Received: from mail.hometree.net ([212.34.181.120]:46766 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S317073AbSIILGQ>; Mon, 9 Sep 2002 07:06:16 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Disabled kernel.org accounts
Date: Mon, 9 Sep 2002 11:11:00 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <alhvk4$obf$1@forge.intermeta.de>
References: <18629.1031548515@kao2.melbourne.sgi.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1031569860 2593 212.34.181.4 (9 Sep 2002 11:11:00 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 9 Sep 2002 11:11:00 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

>On 6 Sep 2002 16:54:17 -0700, 
>"H. Peter Anvin" <hpa@zytor.com> wrote:
>>I have disabled several kernel.org accounts due to bouncing email.
>>If you have a kernel.org account and you can no longer log in, please
>>contact me and provide an updated, *working* email.

>It does not help when 63.209.4.196 does not have a valid reverse DNS.
>Some sites recognize it as neon-gw-l3.transmeta.com but four different
>sites in USA and AUS cannot do a reverse lookup on 63.209.4.196.  That
>makes you look like just another level3 spammer.

Well, the reason for this are missing NS records:

% whois 63.209.4.196@whois.arin.net
[whois.arin.net]

OrgName:    Level 3 Communications, Inc. 
OrgID:      LVLT

NetRange:   63.208.0.0 - 63.215.255.255 
CIDR:       63.208.0.0/13 
NetName:    LEVEL4-CIDR
NetHandle:  NET-63-208-0-0-1
Parent:     NET-63-0-0-0-0
NetType:    Direct Allocation
NameServer: NS1.LEVEL3.NET
NameServer: NS2.LEVEL3.NET

% dig @ns1.level3.net -x 63.209.4.196
[... no answer ...]

% dig @ns2.level3.net -x 63.209.4.196
[... no answer ...]

Go figure. 

ARIN itself says:

% dig @ARROWROOT.ARIN.NET -x 63.209
;; AUTHORITY SECTION:
209.63.in-addr.arpa.    86400   IN      NS      NS1.LEVEL3.net.
209.63.in-addr.arpa.    86400   IN      NS      NS2.LEVEL3.net.

% dig @ns1.level3.net -x 63.209
[... no answer ...]

% dig @ns2.level3.net -x 63.209
[... no answer ...]

So they're a really, really crappy ISP. Maybe they're cheap so
everyone uses them...

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
