Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTJ3N7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbTJ3N7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:59:15 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:1459 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262529AbTJ3N7F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:59:05 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Question on SIGFPE
Date: Thu, 30 Oct 2003 19:27:39 +0530
Message-ID: <94F20261551DC141B6B559DC491086727C8C73@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on SIGFPE
Thread-Index: AcOe7K3Pjw30Ks8QQymK6yDyBIdrtQAAOThw
From: "Sreeram Kumar Ravinoothala" <sreeram.ravinoothala@wipro.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>, "Magnus Naeslund(t)" <mag@fbab.net>
X-OriginalArrivalTime: 30 Oct 2003 13:58:58.0627 (UTC) FILETIME=[F714A930:01C39EED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr Johnson,
	I used it and was able to compile, run. Well it still was
crashing. We are using a mips processor. I am sorry I didn't mention
about this. Thanks a lot for the help.

Regards
Sreeram

---Never doubt that a small group of thoughtful, committed people can
change the world. Indeed, it is the only thing that ever has. -- Copied
from a mail
 

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent: Thursday, October 30, 2003 7:22 PM
To: Sreeram Kumar Ravinoothala
Cc: Magnus Naeslund(t); Linux kernel
Subject: RE: Question on SIGFPE


On Thu, 30 Oct 2003, Sreeram Kumar Ravinoothala wrote:

>
> Hi Mr Johnson,
> 	Thanks for the mail and sorry for pestering you. Actually the
call 
> __setfpucw is not visible anywhere. Should I use
>  _FPU_SETCW(cw) instead of that?
>
> Thanks and Regards
> SReeram

Yes. I just looked on a RH-9 system. The stuff I referenced
was probably before there was a Red Hat!

I don't like that MACRO. Hopefully it works. It accesses memory that may
not exist if you do _FPU_SETCW(_FPU_DEFAULT).

For safety do:

fpu_control_t cw = _FPU_DEFAULT;
_FPU_SETCW(cw);


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


