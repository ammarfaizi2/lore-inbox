Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317442AbSFCRxB>; Mon, 3 Jun 2002 13:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317444AbSFCRxA>; Mon, 3 Jun 2002 13:53:00 -0400
Received: from horus.webmotion.com ([209.87.243.246]:51109 "EHLO
	horus.webmotion.ca") by vger.kernel.org with ESMTP
	id <S317442AbSFCRwQ>; Mon, 3 Jun 2002 13:52:16 -0400
Message-ID: <3CFBACC8.6010002@bonin.ca>
Date: Mon, 03 Jun 2002 13:52:08 -0400
From: Andre Bonin <kernel@bonin.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020516
X-Accept-Language: en-us, fr-ca
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: bonin@bonin.ca
Subject: Support for keyboards with special scancodes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Logitech Internet Navigator keyboard that has nice little 
'play', 'pause', 'e-mail' buttons of all kinds (As many of us do, i 
believe).  I couldn't find any specialised keyboard drivers in the 
kernel.  Only different locales.

I'me wondering if it was possible to write a driver that would overlay 
the existing keyboard driver and pitch non-standardized scancodes codes 
in a /dev file (in a standard format).  One could then create a daemon 
that would poll this file for changes to this file and perform the 
resulting action.

We could create some sort of standardized protocol for many types of 
'special' keyboards.  For example, a logitech keyboards sends a '0x0e' 
as a special scancode.

A simplified example;

The driver reads the scancode and recognizes it as 'Internet Browser'. 
The driver therefore writes a 'IBrowserButton' command in the dev file, 
which would be polled by a daemon/applet and would launch the 
appropriate action relative to this scancode.

Does something like this already exist?

Can I get your comments on my idea?

Thanks!


***********************************
Andre Bonin
Computer Engineering Technologist
Webmotion, Inc.
Ottawa, Ontario
Canada
***********************************

