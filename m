Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275896AbSIURGZ>; Sat, 21 Sep 2002 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275898AbSIURGY>; Sat, 21 Sep 2002 13:06:24 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:53163 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S275896AbSIURGY> convert rfc822-to-8bit; Sat, 21 Sep 2002 13:06:24 -0400
Date: Sat, 21 Sep 2002 19:11:26 +0200
Message-Id: <200209211711.g8LHBQX26908@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: Todor Todorov <ttodorov@web.de>
To: linux-kernel@vger.kernel.org
Subject: eepro100/e100 drivers fragment heavily
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I have a bit of a problem with my Intel based 10/100 pci NIC and kernel 2.4.19, 2.4.20-pre6 and 2.4.20-pre7. I noticed heavy tcp fragmentation when sending data to the network from my linux box. The transfers always stall. The computer is a Dell Inspiron 8000 laptop with an internal Actiontec modem/nic combo pci card based on the Intel Pro chip, running Debian. I observed this behaviour with the eepro100 drivers in 2.4.19, 2.4.20-pre6 and 2.4.20-pre7 and e100 drivers in 2.4.20-pre6 and -pre7. Pulling data from the network is fine and fast though, only sending is a problem.
The only hint I have of what migh be causing the problem is something I read in the specs of my NWAY SOHO switch - it would allow full-duplex 100 MBit/sec only based on auto negotiation, if a nic is in forced mode (say 100 MBit full-duplex), the swith will allow only 100 MBit half-duplex. I tried other high quality switches too, but the result was the same. The other thing worth mentioning is that I have two other servers on the network with pci NICs based on the Realtek RTL 8139 B/D chips and when booting them I always see the message "Setting 100 MBit/sec full-duplex based on auto-negotiation ability". They never have this problem with fragmentation, both pulling and sending data from them is always fast and without any problems. (except when the Dell laptop is involved ;)

So do the eepro100 and e100 drivers have any problem with auto-negotiation? Or does anyone have any other ideas? I'd be glad to run any test you want me to and provide any other information you need, in order to solve this problem.

Thanks in advance.
T.Todorov

______________________________________________________________________________
Jetzt testen für 1 Euro! Ihr All-in-one-Paket! 
https://digitaledienste.web.de/Club/?mc=021106

