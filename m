Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSFJSYd>; Mon, 10 Jun 2002 14:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSFJSYd>; Mon, 10 Jun 2002 14:24:33 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:36851 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S315631AbSFJSYb>; Mon, 10 Jun 2002 14:24:31 -0400
Message-ID: <3D04EDC1.8010402@drugphish.ch>
Date: Mon, 10 Jun 2002 20:19:45 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
In-Reply-To: <Pine.LNX.3.95.1020610141042.17451B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I know there is support for "firewire" in the kernel. Is there
> support for "firewire" disks? If so, how do I enable it?

Yes, there is and it is attached to the SCSI layer via the sbp2 driver. 
You need following set of modules to get it working:

scsi_mod, sd_mod, ohci1394, raw1394, ieee1394, sbp2

I know that you will find out which options you need to enable in the 
kernel config ;).

You might want to check out the CVS version of the ieee1394 drivers but 
I don't think it is necessary. It works perfectly back here with a 
Maxtor 160GB. Funny enough I had 158GB with the VFAT on it and 152GB 
with ext2/ext3.

The speed results were also quite interessing:

VFAT writing     : 12.8 Mbyte/s
ext2/ext3 writing: 19.2 Mbyte/s

I simply like that disk and it's a nice extension for a laptop :).

Cheers,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

