Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbTCGOZs>; Fri, 7 Mar 2003 09:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbTCGOZs>; Fri, 7 Mar 2003 09:25:48 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:23442 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id <S261601AbTCGOZr>; Fri, 7 Mar 2003 09:25:47 -0500
Subject: How can I test my console driver?
From: Alex Bennee <kernel-hacker@bennee.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1047047773.31348.10.camel@cambridge.braddahead>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1-1mdk 
Date: 07 Mar 2003 14:36:14 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm writting a console driver for an embedded system for which the
hardware isn't quite ready yet. As a result I'm building on a PC with a
quickly hacked up proc interface so I can test the logic before the
final hardware.

On loading the module my code does the following:

    take_over_console(&sh_con, MAX_NR_CONSOLES - 1, MAX_NR_CONSOLES - 1,
1);

Which I understand should associate my new console driver with the last
system console (63 in this case). Then to test the console output I do:

    echo "this is a test string" > /dev/vc/63

However my dmesg output shows no sign of any of the console functions
being called to write data, although the module itself has loaded
succesfully and run the take_over_console code.

Obviously I'm mis-understanding how the console should be accessed but
I'm stuck looking for any pointers. I've been looking thorugh the
newport_con.c driver for pointers but so far I've not seen any extra
magic that I'm missing. Can anyone point me in the right direction/offer
some tips?

-- 
Alex, homepage: http://www.bennee.com/~alex/

I want to marry a girl just like the girl that married dear old dad.
		-- Freud

