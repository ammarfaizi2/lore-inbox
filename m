Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVCGNyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVCGNyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVCGNyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:54:24 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:43414 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261180AbVCGNxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:53:52 -0500
MIME-Version: 1.0
Date: Mon,  7 Mar 2005 14:53:36 +0100
To: linux-kernel@vger.kernel.org
X-UMS: email
X-Mailer: TOI Kommunikationscenter V5-0PL2
Subject: Problems with GPM / loading kernel module during boot
From: "RG.Schneider@t-online.de" <RG.Schneider@t-online.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <1D8Ifw-2JN4ym0@cmpmail10.bbul.t-online.de>
X-ID: E29pxwZZZejo0IQJPuFFHC2OA1BPSZEvu7Odo+G+ZabiyZAAHjBY8X@t-dialin.net
X-TOI-MSGID: 85f461be-afec-4873-8ae8-a45625012f21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I found a problem since I started to use the 2.6 kernel release. 
I use the console mouse tool gpm. It is started the usual way with a
script '/etc/init.d/gpm' and symbolic links
in the runlevel directories '/etc/rcX.d" .
When I installed gpm ( Debian Distribution ) I wondered that gpm was not
active after booting. I had to call
'/etc/init.d/gpm start' after login as root  to make it working.

I started to look at the problem after login and everything else seemed
to be ok, even lsmod showed the neccessary modules
- psmouse ... - in this case for gpm.

I stopped gpm  ( gpm -k ) , unloded the psmouse ... and restarted gpm
again. Not working but psmouse was loaded again.
So I thought that the request to the kernel to load the modules
corresponding to '/dev/psaux' took too long for gpm to 
come up.

To validate this, I made an entry 'psmouse' into the file '/etc/modules'
- the list of modules that are loaded during boot.
This solved the problem.

QUESTION::
Is this a special problem for thegpm program or  a general problem for
all programs/drivers that are trying to access a device node and forcing
the kernel to load the approciate module(s)?

/RalfS 

 


