Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTEZUjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbTEZUjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:39:42 -0400
Received: from pl484.nas911.n-yokohama.nttpc.ne.jp ([210.139.38.228]:33988
	"EHLO standard.erephon") by vger.kernel.org with ESMTP
	id S262228AbTEZUjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:39:39 -0400
Message-ID: <3ED27E9A.E9869E6@yk.rim.or.jp>
Date: Tue, 27 May 2003 05:52:42 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: dougg@torque.net
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFR] a new SCSI driver
References: <20030524195123.GA8394@gtf.org> <3ED1831F.30203@torque.net>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Thinking about how existing applications such as
> hdparm and smartmontools will cope with an ATA device
> (e.g. a disk) with a device node like "/dev/sdb".
> Those apps would make the assumption from the device
> name that such a device should be sent a SCSI command
> set. So perhaps we need a "transport" indicator in
> the sysfs directory for that device (dare I mention
> another ioctl).

As of now, smartmontools uses /etc/smartd.conf in which
we can specify a device type is ata or scsi
if the device name is not clear enough. (-d scsi or
-d ata). I am not sure why this feature is there. Maybe
devfs name thing.

Upon cursor examination, 
I am not entirely sure whether we can
*always* put a meaningful "transport indicator" in the sysfs
directory when there will be multiple
combination of transport layer(s) over the long term/haul.
For this particular situation of SATA and SCSI, yes, though.
(As the technology trend goes, I won't be surprised to
find a home PC that hooks SCSI device via a few different
transport layers such as serial, another different serial,
say, USB, and other transport layer, say, firewire
with some glue gadgets in between. 
Whether such beast will be supported
under linux, I am not sure. But we do support USB 
storage device as a SCSI device, so there may be some demand.
I am sure there will be some cheap interface boxes that probably
work under some other OSs when everything works perfectly.
I am not recommending it,  but some people will be hooked to
such setup.)




-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
