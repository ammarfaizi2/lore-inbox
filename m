Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRBWR1t>; Fri, 23 Feb 2001 12:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131136AbRBWR1j>; Fri, 23 Feb 2001 12:27:39 -0500
Received: from [194.25.167.189] ([194.25.167.189]:266 "EHLO
	trweb5.isp.icteam.de") by vger.kernel.org with ESMTP
	id <S129156AbRBWR11> convert rfc822-to-8bit; Fri, 23 Feb 2001 12:27:27 -0500
Date: Fri, 23 Feb 2001 18:27:10 +0100
From: Rolf Offermanns <rolf@offermanns.de>
To: linux-kernel@vger.kernel.org
Subject: isapnp question
Message-ID: <3700287292.982952830@[192.168.120.254]>
X-Mailer: Mulberry/2.0.6 (Win32 Demo)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-OriginalArrivalTime: 23 Feb 2001 17:32:42.0438 (UTC) FILETIME=[A041AE60:01C09DBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel developers!

Can someone tell me how to find out the parameter i have to pass to the ISAPNP_FUNCTION(x)?

This is my cat '/proc/isapnp' output:
------------
Card 1 'TER2111:TerraTec ActiveRadio' PnP version 1.0 Product version 1.1
  Logical device 0 'TER2111:Unknown'
    Supported registers 0x2
    Device is not active
    Active DMA ,0
    Resources 0
      Priority preferred
      Port 0x590-0x590, align 0x0, size 0x1, 16-bit address decoding
      Port 0x591-0x591, align 0x0, size 0x1, 16-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x590-0x5a8, align 0x7, size 0x1, 16-bit address decoding
        Port 0x591-0x5a9, align 0x7, size 0x1, 16-bit address decoding
      Alternate resources 0:2
        Priority functional
        Port 0x590-0x5c8, align 0x7, size 0x1, 16-bit address decoding
        Port 0x591-0x5c9, align 0x7, size 0x1, 16-bit address decoding
-------
To start, I would call (taken from the radio-cadet.c driver):	
dev = isapnp_find_dev (NULL, ISAPNP_VENDOR('T','E','R'),
		                       ISAPNP_FUNCTION(???), NULL);

Is this correct? How do I know what to pass to the ISAPNP_FUNCTION?
The doc. says, I can take it from the /proc/isapnp file, but which value is 
it?
I tried '0', but that didn´t work.

Can someone help me please?
(If possible please CC me)

Thanks,
Rolf


