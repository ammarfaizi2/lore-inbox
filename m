Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbTAFO3B>; Mon, 6 Jan 2003 09:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbTAFO3B>; Mon, 6 Jan 2003 09:29:01 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:5564 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id <S265587AbTAFO3A>; Mon, 6 Jan 2003 09:29:00 -0500
Subject: Why do some net drivers require __OPTIMIZE__?
From: Alex Bennee <alex@braddahead.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 06 Jan 2003 14:33:29 +0000
Message-Id: <1041863609.21044.11.camel@cambridge.braddahead>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been doing a bring up on an embedded kernel and to prevent gdb
making me go google eyed I notched the optimization level down to -O0
for the time being. This broke the natsemi network driver and I noticed
this stanza appears in a few places:

#if !defined(__OPTIMIZE__)
#warning  You must compile this file with the correct options!
#warning  See the last lines of the source file.
#error You must compile this driver with "-O".
#endif

Despite the comments I couldn't see an explanation at the bottom of the
source file and a quick google showed a few patches where this was
removed but no explanation.

Does anybody know the history behind those lines? Do they serve any
purpose now or in the past? Should I be nervous about compiling the
kernel at a *lower* than normal optimization level? After all
optimizations are generally processor specific and shouldn't affect the
meaning of the C.

-- 
Alex Bennee
Senior Hacker, Braddahead Ltd
The above is probably my personal opinion and may not be that of my
employer

