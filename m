Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272712AbRIGTPJ>; Fri, 7 Sep 2001 15:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272828AbRIGTO6>; Fri, 7 Sep 2001 15:14:58 -0400
Received: from 11.ylenurme.ee ([193.40.6.11]:3541 "HELO mail.linking.sise")
	by vger.kernel.org with SMTP id <S272712AbRIGTOn>;
	Fri, 7 Sep 2001 15:14:43 -0400
Message-ID: <33357.10.110.1.3.999890040.squirrel@10.110.0.21>
Date: Fri, 7 Sep 2001 21:14:00 +0200 (EET)
Subject: iptables/advanced routing
From: "Elmer Joandi" <elmer@linking.ee>
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_?hOe4ym7uCUUmuF/Ihy2ac+g'JRBhu6Lcs6I93'8k6_1+.9Kt((9d7+PLMc6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


------=_?hOe4ym7uCUUmuF/Ihy2ac+g'JRBhu6Lcs6I93'8k6_1+.9Kt((9d7+PLMc6
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit

2.4.2-ac3
ip rule :  many rules
ip route: several tables
doing nat, tunnels, source address based routing, QoS

Problems:

1. ICMP packets do not pass advanced routing rules and tables, take default 
route and associated outgoing source address from main table.
	1. nat tunnel icmp fragmentation gets correct source address but bad 
	route
	2. non-nat generated icmp gets also source address from main table.
	3. itf main table does not have default, icmp source address decision 
	could go trough rules.

2. iptables does not accept SNAT in PREROUTING  chain. Which makes ip rule 
tables very long, much longer than it could be if source address would be 
changed before routing.



------=_?hOe4ym7uCUUmuF/Ihy2ac+g'JRBhu6Lcs6I93'8k6_1+.9Kt((9d7+PLMc6
Content-Type: application/octet-stream;name=""
Content-Disposition: attachment; filename=""
Content-Transfer-Encoding: base64

DQo=

------=_?hOe4ym7uCUUmuF/Ihy2ac+g'JRBhu6Lcs6I93'8k6_1+.9Kt((9d7+PLMc6--

