Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVLZWdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVLZWdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVLZWdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:33:55 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3797 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751088AbVLZWdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:33:54 -0500
Date: Mon, 26 Dec 2005 23:33:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jason Munro <jason@stdbev.com>
cc: Lee Revell <rlrevell@joe-job.com>, rostedt@goodmis.org, jaco@kroon.co.za,
       linux-kernel@vger.kernel.org, pavel@ucw.cz, s0348365@sms.ed.ac.uk
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
 support (try 2)
In-Reply-To: <0f197de4ee389204cc946086d1a04b54@stdbev.com>
Message-ID: <Pine.LNX.4.61.0512262327460.12671@yvahk01.tjqt.qr>
References: <43AF7724.8090302@kroon.co.za>            <43AFB005.50608@kroon.co.za>
            <1135607906.5774.23.camel@localhost.localdomain>           
 <200512261535.09307.s0348365@sms.ed.ac.uk>            <1135619641.8293.50.camel@mindpipe>
 <0f197de4ee389204cc946086d1a04b54@stdbev.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Maybe this is a stupid question but in terms of inline patches what exactly
>would be ideal behavior from a mail client for LKML patch submitters? What
>line lengths are expected to be maintained, preferred encodings, tabs vs.
>spaces, etc? I have noticed that some patch submitters append an EOF after
>the patch, while others do not.

That's because not provind #eof could potentially bring problems (not with 
the clever poster, though), e.g. in:

--- a/lalala
+++ b/lalala
@@ -123,456 +789,1012 @@
 contextline1
 contextline2
 contextline3
-remove
+added

My name
dash dash space
my signature


There are actually two problems in there.
The first is that some empty context lines are missing,
the second is that they have to have a leading space, too.
The #eof I am adding is basically so that you see when a patch is really 
ending, because there is also diff's -c option which you can tune the 
number of potentially empty lines.


Jan Engelhardt
-- 
