Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWDDNcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWDDNcl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 09:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWDDNcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 09:32:41 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:34189 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964789AbWDDNck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 09:32:40 -0400
Message-ID: <44327574.1030803@smallworld.cx>
Date: Tue, 04 Apr 2006 14:32:36 +0100
From: Ian Leonard <ian@smallworld.cx>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial port problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The trouble started when I upgraded a machine from FC3 to FC4. It had a 
serial touchscreen. With FC4 it stopped working completely. I added 
debug to the X input driver and found read() permanently blocked despite 
the file having been opened with O_NDELAY.

I then tried a simple test with two machine connected with a serial 
cable and using minicom to send characters both ways. One was a laptop. 
If you typed from the failing machine to the laptop all was well. Typing 
the other way caused one character to be displayed and then it hung 
(although I could use 'cat >/dev/ttyS0' to send data just fine).

I then repeated the test using 4 different motherboards. 2 exhibited the 
problem 2 didn't. So to recap, sending data without changing the driver 
settings (stty) seems to work. Configuring the port seems to cause a 
problem on some motherboards. One of those is a VIA mini-itx. The other 
is more standard Gigabyte.

I have tried using the standard FC4 kernel and 2.6.15.6.

Not sure what to try next, so any pointer gratefully received.


-- 
Ian Leonard

Please ignore spelling and punctuation - I did.
