Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWDFMgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWDFMgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 08:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWDFMgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 08:36:22 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:35472 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751233AbWDFMgW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 08:36:22 -0400
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: serge.noiraud@bull.net
Date: Thu, 06 Apr 2006 14:40:02 +0200
Message-Id: <1144327202.3819.37.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 06/04/2006 14:38:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 06/04/2006 14:38:34,
	Serialize complete at 06/04/2006 14:38:34
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Serge,

Serge Noiraud wrote:
>Hi,
>
>	I always have the same problem since 2.6.16.
>A 2.6.16 kernel boot correctly.
>The 2.6.16+RT patch doesn't. ( I tried all versions rt1-rt12 without success )
>The LSM module is also added ( patch ).
>
>I get symbol resolution error when I try to load my scsi modules in the initrd.
>

 <snip>

>Could not allocate 8 bytes percpu data
>mptscsih: Unknown symbol scsi_remove_host

  Maybe you should try increasing PERCPU_ENOUGH_ROOM in /include/linux/percpu.h
128K may not be enough for your setup. I had it set to 192K before it was bumped
from 64K to 128K in the rt patches. Now 128K is OK for me.

  Cheers,

  Sébastien.


-- 
-----------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol

-----------------------------------------------------

