Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbUAET15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbUAET15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:27:57 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:779 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S264415AbUAET14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:27:56 -0500
Date: Mon, 5 Jan 2004 20:24:30 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Weird problems with printer using USB
Message-ID: <20040105192430.GA15884@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I have a Lexmark E312 laser printer, which comes with both a parallel
port and an USB port. It interprets PostScript, so when I print I
simply 'cat' the file to the printer device (together with some
codes, quite simple). This method works smoothly when using the
printer through the parallel port, no problem, but when I use the USB
port, sometimes I get the following:

kernel: host/usb-uhci.c: interrupt, status 2, frame# 682
kernel: printer.c: usblp0: nonzero read/write bulk status received: -110
kernel: printer.c: usblp0: error -84 reading printer status
kernel: printer.c: usblp0: removed

    I have shown one of each error messages I get in my system logs.
Normally I get a couple or three of the first message, a few of the
last and a good bunch of the another two. Whenever I get the message
about the 'bulk status', the printer dies and I must turn cycle it.

    I'm using kernel 2.4.21, if this matters...

    Since the parallel port works OK, I know the printer works. So
the culprit must be:

    - The USB interface of the printer. Not likely, but...
    - The driver for usblp0
    - The driver for USB uhci
    - Me (most likely)

    Is that a symptom of misconfiguration? Must I do anything more
than a simple cat for printing trhu USB)? Can I tune anything for
getting better timing or the like (if it is a timing problem, of
course...)? I thought that the printer was broken, but when I tested
printing through the parallel port and it worked...

    Thanks in advance, and sorry if this is documented, I haven't
found any information about this :(

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
