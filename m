Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271487AbRHXNhQ>; Fri, 24 Aug 2001 09:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271505AbRHXNhG>; Fri, 24 Aug 2001 09:37:06 -0400
Received: from ns1.biochem.mpg.de ([141.61.1.32]:12808 "HELO
	ns1.biochem.mpg.de") by vger.kernel.org with SMTP
	id <S271487AbRHXNg4>; Fri, 24 Aug 2001 09:36:56 -0400
Message-ID: <3B865882.24D57941@biochem.mpg.de>
Date: Fri, 24 Aug 2001 15:37:06 +0200
From: Bernhard Busch <bbusch@biochem.mpg.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Poor Performance for ethernet bonding 
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


I have tried to use ethernet  network interfaces bonding to increase
peformance.

Bonding is working fine, but the performance is rather poor.
FTP between 2 machines ( kernel 2.4.4 and 4 port DLink 100Mbit ethernet
card)
results in a transfer rate of 3MB/s).

Any Hints?


here is my setup for the channel bonding

insmod bonding
insmod tulip
ifconfig bond0 192.168.100.2 netmask 255.255.255.0 broadcast
192.168.100.255
ifconfig bond0 down
./ifenslave  -v bond0 eth2 eth3 eth4 eth5
ifconfig bond0 up
route add -host 192.168.100.1 dev bond0


Many thanks for every help

Bernhard

--
Dr. Bernhard Busch
Max-Planck-Institut für Biochemie
Am Klopferspitz 18a
D-82152 Martinsried
Tel: +48(89)8578-2582
Fax: +49(89)8578-2479
Email bbusch@biochem.mpg.de



