Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313109AbSDEQwq>; Fri, 5 Apr 2002 11:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313102AbSDEQwg>; Fri, 5 Apr 2002 11:52:36 -0500
Received: from luna.tlmat.unican.es ([193.144.186.2]:26126 "EHLO
	luna.tlmat.unican.es") by vger.kernel.org with ESMTP
	id <S312852AbSDEQwa>; Fri, 5 Apr 2002 11:52:30 -0500
From: "Johnny Choque" <jchoque@tlmat.unican.es>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with skb_copy
Date: Fri, 5 Apr 2002 18:57:47 +0200
Message-ID: <NDBBLMLMCKPEIBAPMLCHOEHMCGAA.jchoque@tlmat.unican.es>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all !

    I'm programming a module at kernel level. For each socket_buffer
arriving to my module, I have to create one or more new socket_buffers that
must be identical to the original one, but the original socket buffer's data
field must be divided into as many fragments as new socket buffers have to
be created. Each fragment must be copied into each new socket buffer's data
field. Then I send them by the wireless channel and finally rebuild the
original at the receiver.

    To accomplish this, I have used the skb_copy function. The problem is
that when I'm sending UDP packets using the nttcp tool, only more or less
half of them achieve the transmitter pcmcia card's driver, whatever the
number of sent packets is (always over 1000 packets). And, of course, only
half of them arrive to the receiver.

    I have also tried to clone the packets (using the skb_clone function)
instead of copy them, but the problem persists.

    Does anyone know what the solution is? Has anyone have any problem using
either skb_copy or skb_clone functions ?

   Thanks in advanced.
   Best regards.

PD: Using counter variables I have notice that the packets are dropped in
the
net_device but I don't kown neither why nor where.

----------------------------------------
Johnny Choque
University of Cantabria
Department of Communications Engineering
39005 Santander - Spain

Phone: +34-942-201387
Fax  : +34-942-201488

E-mail: jchoque@tlmat.unican.es
----------------------------------------

