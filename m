Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTKQTZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 14:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTKQTZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 14:25:50 -0500
Received: from mout2.freenet.de ([194.97.50.155]:47839 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S263595AbTKQTZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 14:25:48 -0500
Message-ID: <1069097145.3fb920b9a10b1@fvs.dnsalias.net>
Date: Mon, 17 Nov 2003 20:25:45 +0100
From: Maximilian Mehnert <mmehnert@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.0-test9, deadlock using usb-storage, eventually memory allocation bug
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 217.186.38.190
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everybody!

So far I have spoken to Jari Ruusu <jariruusu@users.sourceforge.net> who
is maintaining loop-AES and to Matthew Dharm <mdharm-usb@one-eyed-alien.net>
who
seems to be maintaining usb-storage at the moment.

Jari Ruusu helped me by locating the whereabouts of the following bug by
reading
my syslogs with debugging output from usb-storage and by providing some kernel
patches to isolate the error:
I am using a harddisk attached via a cardbus usb 2.0 card. On it I have an
encrypted partition which I access via loop-AES.
I can easily reproduce a complete deadlock in the usb-storage system by
mounting
my encrypted partition or copying files to or from it (depends on
configuration).

That's what Jari Ruusu wrote on Sun, 09 Nov 2003:
> It was very similar memory allocation failure again: usb storage RAM alloc
> waited for pages to be freed, and all freeable pages were waiting to be
> written out to your usb device. Same thing, just different place.


On Sun, Nov 16, 2003 at 12:48:42PM -0800, Matthew Dharm wrote:
> You should take this up with linux-kernel@vger.kernel.org -- it's a memory
> allocation problem, not a usb-storage problem.  I can't fix it.

I did without posting my kernel config and my syslog files with the usb-storage
messages as according to the FAQ this would be overkill.

If anybody is willing to help me I  would gratefully send her/him all my logs
and my previous correspondence on this topic :)

Greetings from Berlin && excuses for my bad English,

Maximilian

-- 
Maximilian Mehnert <mmehnert at gmx dot net>
http://members.lycos.co.uk/endofuniverse/gpg.html
Fingerprint: 387F 5AA6 5856 2A49 C88C  DA86 FBA8 5122 817B C60E


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
