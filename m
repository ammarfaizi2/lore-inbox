Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWHQF62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWHQF62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWHQF61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:58:27 -0400
Received: from outgoing3.smtp.agnat.pl ([193.239.44.85]:37533 "EHLO
	outgoing3.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1750792AbWHQF60 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:58:26 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: qlogic 2312 problems on 2.6.16.22, 2.6.18rc4
Date: Thu, 17 Aug 2006 07:58:19 +0200
User-Agent: KMail/1.9.4
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200608140946.50411.arekm@pld-linux.org> <200608162310.26541.arekm@pld-linux.org> <20060816221751.GW3674@andrew-vasquezs-computer.local>
In-Reply-To: <20060816221751.GW3674@andrew-vasquezs-computer.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608170758.19344.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 00:17, Andrew Vasquez wrote:

> > I started dd'ing text file onto /dev/sda2, then back to tmpfs and diffing
> > these. Corruption is one byte, several not corrupted bytes and again one
> > corrupted byte. Some regular pattern.
>
> Could you send me the a snippet (2 to 4KB) of the good and bad data?

The corruption doesn't happen so often. I need 1MB of data to see 5 bytes 
corrupted.

[root@pldmachine ~]# dd if=xok of=/dev/sda2 bs=1M count=1
1+0 records in
1+0 records out
[root@pldmachine ~]# dd if=/dev/sda2 of=try1 bs=1M count=1
1+0 records in
1+0 records out
[root@pldmachine ~]# dd if=/dev/sda2 of=try2 bs=1M count=1
1+0 records in
1+0 records out
[root@pldmachine ~]# dd if=/dev/sda2 of=try3 bs=1M count=1
1+0 records in
1+0 records out

results http://ep09.pld-linux.org/~arekm/qlogic/

>
> Regards,
> Andrew Vasquez

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
