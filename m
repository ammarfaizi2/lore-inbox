Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129848AbRB0Umg>; Tue, 27 Feb 2001 15:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbRB0Um0>; Tue, 27 Feb 2001 15:42:26 -0500
Received: from cartero.unavarra.es ([130.206.166.80]:40149 "EHLO
	cartero.unavarra.es") by vger.kernel.org with ESMTP
	id <S129848AbRB0UmX>; Tue, 27 Feb 2001 15:42:23 -0500
Message-ID: <3A9C1131.7ABD6867@unavarra.es>
Date: Tue, 27 Feb 2001 21:42:25 +0100
From: Eduardo Magaña Lizarrondo 
	<eduardo.magana@unavarra.es>
Organization: Universidad Publica de Navarra
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux Socket Filter sudden CPU use increase
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been testing Linux Socket Filters (LSF) these weeks (kernels
2.2.12,
2.2.14, 2.2.18, 2.4.1) with libpcap (0.4 - 0.6.2) and I have observed 
something curious. I make a program that increase number of simultaneous 
LSF filters (5, 10, 15..) and when this number is between 15 and 50,
suddenly
CPU consumed by kernel increases suddenly. Any idea? 
(you can see a figure of CPU vs. number of LSF filter in 
http://www.tlm.unavarra.es/~eduardo/varios/lsf.gif)

I do not see anything stranger. Only, using Linux Trace Toolkit with
some 
modifications when there are few filters, I observe that of timer Bottom
Half 
follows IRQ 0. And when there are more filters, IRQ 0 takes place when
the 
network Bottom Half is taking place, so the timer Bottom Half is delayed
to
the end of the network Bottom Half. Can it be related?

To measure kernel CPU I have used the trick of running another CPU with
low 
priority. According to the time this second process is delayed an
aproximate 
%CPU is obtained.

I do not understand what is happening. Any help would be very useful.

	Eduardo

-- 
Eduardo Magaña Lizarrondo
http://www.tlm.unavarra.es/~eduardo
