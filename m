Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTH2IMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 04:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTH2IMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 04:12:41 -0400
Received: from village.ehouse.ru ([193.111.92.18]:40463 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264407AbTH2IMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 04:12:39 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-testX and InnoDB (was: Re: 2.6.0-test2-mm3 and mysql)
Date: Fri, 29 Aug 2003 12:12:39 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <1059871132.2302.33.camel@mars.goatskin.org> <200308282015.15580.rathamahata@php4.ru> <20030828125010.7b45407d.akpm@osdl.org>
In-Reply-To: <20030828125010.7b45407d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308291212.39238.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thursday 28 August 2003 23:50, Andrew Morton wrote:
> "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
> > And here is another one InnoDB crash I've just got with 2.6.0-test4.
>
> Which filesystem?

It's a reiserfs (v3.6)
/dev/md/2 on /var/lib type reiserfs (rw,noatime,nodiratime,notail)

>
> What sort of I/O system?
It's a software raid1 over two scsi discs attached to
00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891

Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K2-TY734L Rev: DDD6
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 09 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K2-TY734L Rev: DDD6
  Type:   Direct-Access                    ANSI SCSI revision: 03

>
> Please grab http://www.zip.com.au/~akpm/linux/patches/stuff/fsx-linux.c
>
> and run
>
> 	./fsx-linux foo -s <physmem-in-bytes> foo
>
> on that machine for 12 hours or so.  Where <physmem-in-bytes> is (say)
> 256000000 on a 256-MB machine.
>
> If the machine has more than a couple of gigabytes you'll need to run
> multiple instances, against different files.
>
> Make sure that a decent amount of I/O is happening during the run.

Ok, will do this evening. Thank you.


-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
