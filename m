Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270026AbUJHP2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270026AbUJHP2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270027AbUJHP2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:28:22 -0400
Received: from hs-grafik.net ([80.237.205.72]:60652 "EHLO
	ds80-237-205-72.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id S270026AbUJHP1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:27:32 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: pppoe broken in 2.6.9-rc2-mm1, working in 2.6.7-mm1 and 2.6.7-rc3
Date: Fri, 8 Oct 2004 17:36:05 +0200
User-Agent: KMail/1.7
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410081736.05976@zodiac.zodiac.dnsalias.org>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

pppoe doesnot work for me on 2.6.9-rc2-mm1. It works with  2.6.7-mm1 and 
2.6.7-rc3.
The problem seems to be that one package is missing:
2.6.7 does this:
17:31:09.042999 PPPoE PADI
17:31:09.358382 PPPoE PADO [AC-Name "AACX11-erx"] [Service-Name] [AC-Cookie 
0xC18B5C6E2ECF4E0C6CFBB17EE5777E82]
17:31:09.358466 PPPoE PADR [Service-Name] [AC-Cookie 
0xC18B5C6E2ECF4E0C6CFBB17EE5777E82]
17:31:09.651898 PPPoE PADS [ses 0x107d] [Service-Name] [AC-Name "AACX11-erx"] 
[AC-Cookie 0xC18B5C6E2ECF4E0C6CFBB17EE5777E82]
17:31:10.037167 PPPoE  [ses 0x107d] LCP, Conf-Request (0x01), id 1, Magic-Num  
0x0024067c, PFC , length 12
        0x0000:  c021 0101 000c 0506 0024 067c 0702
17:31:10.145315 PPPoE  [ses 0x107d] LCP, Conf-Request (0x01), id 96, MRU  
1492, Auth-Prot  PAP, Magic-Num  0x718234ae, length 18
        0x0000:  c021 0160 0012 0104 05d4 0304 c023 0506
        0x0010:  7182 34ae
17:31:10.145766 PPPoE  [ses 0x107d] LCP, Conf-Ack (0x02), id 96, MRU  1492, 
Auth-Prot  PAP, Magic-Num  0x718234ae, length 18
        0x0000:  c021 0260 0012 0104 05d4 0304 c023 0506
        0x0010:  7182 34ae
17:31:10.147435 PPPoE  [ses 0x107d] LCP, Conf-Ack (0x02), id 1, Magic-Num  
0x0024067c, PFC , length 12
        0x0000:  c021 0201 000c 0506 0024 067c 0702
17:31:10.148875 PPPoE  [ses 0x107d] LCP, Echo-Request (0x09), id 0, Magic-Num 
0x0024067c, length 8
        0x0000:  c021 0900 0008 0024 067c
17:31:10.148878 PPPoE  [ses 0x107d] Auth-Req(1), Peer 
0002567923935200490773370001@t-online.de, Name 09856472
17:31:10.260645 PPPoE  [ses 0x107d] LCP, Echo-Reply (0x0a), id 0, Magic-Num 
0x718234ae, length 8
        0x0000:  c021 0a00 0008 7182 34ae
17:31:10.535034 PPPoE  [ses 0x107d] Auth-Ack(1), Msg
17:31:10.535561 PPPoE  [ses 0x107d] unknown, Conf-Request (0x01), id 1, 
Deflate, MVRCA, BSD-Comp, length 15
        0x0000:  80fd 0101 000f 1a04 7800 1804 7800 1503
        0x0010:  2f

2.6.9 does not send 
17:31:10.037167 PPPoE  [ses 0x107d] LCP, Conf-Request (0x01), id 1, Magic-Num  
0x0024067c, PFC , length 12
        0x0000:  c021 0101 000c 0506 0024 067c 0702
and than the AC does not respond to the follwoing packages.

regards
Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

