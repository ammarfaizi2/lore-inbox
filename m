Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267754AbTBJLQk>; Mon, 10 Feb 2003 06:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267760AbTBJLQj>; Mon, 10 Feb 2003 06:16:39 -0500
Received: from buitenpost.surfnet.nl ([192.87.108.12]:19153 "EHLO
	buitenpost.surfnet.nl") by vger.kernel.org with ESMTP
	id <S267754AbTBJLQW>; Mon, 10 Feb 2003 06:16:22 -0500
Date: Mon, 10 Feb 2003 12:32:11 +0100
From: Niels den Otter <otter@surfnet.nl>
To: linux-kernel@vger.kernel.org
Subject: IGMP problem with 2.5 kernels
Message-ID: <20030210113210.GA4827@pangsit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have tried to run several IP Multicast applications (SDR, Vat,...)
with on 2.5 kernels (now running 2.5.59bk3) without succes. Same
applications appear to work on 2.4 kernels.

What seems to be happening is that the application binds to the lo
interface instead of eth0 so that no IGMP queries are send out on the
ethernet interface. I have a small application that tries to listen to
address 233.4.5.9 and here is /proc/net/igmp with and without the app  
running:

Withtout app running:
 Idx     Device    : Count Querier       Group    Users Timer    Reporter
 1       lo        :     0      V2
                                 010000E0     1 0:FFF779D7               0
 2       eth0      :     3      V2
                                 010000E0     1 0:400DA3C3               0

With app running:
 Idx     Device    : Count Querier       Group    Users Timer    Reporter
 1       lo        :     0      V2
                                 090504E9     1 1:00000C28               1 
                                 010000E0     1 0:FFF73910               0
 2       eth0      :     3      V2
                                 010000E0     1 0:400D62FC               0

Is there a known problem? Or should multicast applications be changed to
run on 2.5 kernels?


Thanks,

Niels
