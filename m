Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266580AbSIRNoL>; Wed, 18 Sep 2002 09:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266618AbSIRNoL>; Wed, 18 Sep 2002 09:44:11 -0400
Received: from web13308.mail.yahoo.com ([216.136.175.44]:38430 "HELO
	web13308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266580AbSIRNoK>; Wed, 18 Sep 2002 09:44:10 -0400
Message-ID: <20020918134907.13218.qmail@web13308.mail.yahoo.com>
Date: Wed, 18 Sep 2002 15:49:07 +0200 (CEST)
From: =?iso-8859-1?q?Joerg=20Pommnitz?= <pommnitz@yahoo.com>
Subject: Re: [PATCH]  Networking:  send-to-self
To: linux-kernel@vger.kernel.org
Cc: greearb@candelatech.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,
I had the exact same problem in March (see 
http://marc.theaimsgroup.com/?l=linux-kernel&m=101679264814811&w=2). The 
hacky solution I came up with was to use the following NAT rule:

iptables -t nat -A POSTROUTING -o eth0 -d 10.1.12.151 -p udp --dport 12345
-j SNAT --to 1.2.3.4

This way the packets claimed to come from a foreign IP address and were 
accepted. However, when the packets hit an ingress filter on their way,
this will fail. 

Will you push this to DaveM for inclusion?

Regards
  Jörg

=====
-- 
Regards
       Joerg


__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de
