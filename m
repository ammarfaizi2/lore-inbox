Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269061AbUHZPdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269061AbUHZPdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269062AbUHZPdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:33:16 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:16376 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S269056AbUHZPbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:31:00 -0400
Message-ID: <412E012F.4050503@ttnet.net.tr>
Date: Thu, 26 Aug 2004 18:26:39 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: Re: Linux 2.4.28-pre2
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo:

 > Also a bunch of gcc 3.4 fixes, hopefully we are done
 > with that now.

Fairly close, but not complete. You need the two patches at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109327862717567&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109292095518054&w=2

(You should have them in your mailbox)

After those, there will still be five warnings which I couldn't
find an easy way to deal with:
1. the rio driver:
rio_linux.c: In function `rio_init':
rio_linux.c:1209: warning: use of cast expressions as lvalues is deprecated
rio_linux.c:1333: warning: use of cast expressions as lvalues is deprecated

2. isdn/eicon:
eicon_idi.c: In function `idi_faxdata_send':
eicon_idi.c:2057: warning: use of cast expressions as lvalues is deprecated

3. scsi/53c7,8xx.c:
53c7,8xx.c: In function `NCR53c7xx_queue_command':
53c7,8xx.c:3929: warning: use of cast expressions as lvalues is deprecated

4. rivafb:
accel.c: In function `fbcon_riva_writechr':
accel.c:157: warning: use of cast expressions as lvalues is deprecated

5. affs/super.c :
super.c: In function `parse_options':
super.c:133: warning: use of conditional expressions as lvalues is 
deprecated

As you know these are warnings in gcc3.4 but will be failures in 3.5.

Another thing is in scsi/ultrastor.c:
ultrastor.c: In function `ultrastor_queuecommand':
ultrastor.c:301: warning: matching constraint does not allow a register
ultrastor.c:301: warning: matching constraint does not allow a register

I'm no asm guy so I don't know how serious/how to fix this.

Regards,
Ozkan.
