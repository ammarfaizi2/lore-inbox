Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282133AbRLQSwi>; Mon, 17 Dec 2001 13:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282129AbRLQSw3>; Mon, 17 Dec 2001 13:52:29 -0500
Received: from nc-ashvl-66-169-84-151.charternc.net ([66.169.84.151]:14466
	"EHLO orp.orf.cx") by vger.kernel.org with ESMTP id <S282133AbRLQSwU>;
	Mon, 17 Dec 2001 13:52:20 -0500
Message-Id: <200112171852.fBHIqJR05703@orp.orf.cx>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: modify_ldt returning ENOMEM on highmem
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcD
 b+Y'p'sCMJ
From: Leigh Orf <orf@mailbag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Dec 2001 13:52:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Holger Lubitz wrote:

|   Hi,
|   
|   I tried posting this before, but apparently it didn't get through to the
|   list.
|   The following are the final lines of a strace of a failing mplayer:
|   
|   [...]
|   modify_ldt(0x1, 0xbffff85c, 0x10)       = -1 ENOMEM (Cannot allocate
|   memory)
|   --- SIGSEGV (Segmentation fault) ---
|   +++ killed by SIGSEGV +++

Do you have an NTFS disk mounted? I had a similar problem which was
"fixed" by not having an NTFS vol mounted. Apparently the ntfs code
makes a lot of calls to vmalloc which leads to badness.

See http://www.uwsg.indiana.edu/hypermail/linux/kernel/0112.1/0878.html
if interested.

Leigh Orf

