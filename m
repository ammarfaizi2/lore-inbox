Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVLSSHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVLSSHJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 13:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVLSSHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 13:07:09 -0500
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:9101 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932342AbVLSSHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 13:07:07 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'JaniD++'" <djani22@dynamicweb.hu>, <linux-kernel@vger.kernel.org>
Subject: RE: buffer cache question
Date: Mon, 19 Dec 2005 12:15:28 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYEfHJ+uJp60enQT7mJipnt+bcMOgASmPxw
In-Reply-To: <000001c6047c$a2458a40$0400a8c0@dcccs>
Message-ID: <EXCHG2003iSnRMWuLn500000618@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 19 Dec 2005 18:01:07.0074 (UTC) FILETIME=[2F547E20:01C604C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of JaniD++
> Sent: Sunday, December 18, 2005 3:09 PM
> To: linux-kernel@vger.kernel.org
> Subject: buffer cache question
> 
> Hello, list,
> 
> I use 4 disk nodes with NBD.
> All of my nodes have 2GB ram.
> 
> But the buffer cache newer rise over 830MB.
> 
> Is there some limit?

For writes only 40% of the ram can be "dirty".

> Where can i change this limit? (if it is)

I believe there is a way to change it, I am pretty sure that it has
been discussed on the kernel list a couple of months ago, I 
don't remember exactly what the change is, and I think the change
was more complicated that was obvious.

The previous subject on a similar thing was:
"kernel 2.6.13 buffer strangeness"

                           Roger

> 
> Thanks,
> Janos
> 
> [root@st-0001 root]# free
>              total       used       free     shared    
> buffers     cached
> Mem:       2073152     933188    1139964          0     
> 836776      43416
> -/+ buffers/cache:      52996    2020156
> Swap:            0          0          0
> [root@st-0001 root]# cat /proc/meminfo
> MemTotal:      2073152 kB
> MemFree:       1139012 kB
> Buffers:        835928 kB
> Cached:          43448 kB
> SwapCached:          0 kB
> Active:          12872 kB
> Inactive:       871424 kB
> HighTotal:     1179584 kB
> HighFree:      1129764 kB
> LowTotal:       893568 kB
> LowFree:          9248 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:               0 kB
> Writeback:           0 kB
> Mapped:           9104 kB
> Slab:            30248 kB
> CommitLimit:   1036576 kB
> Committed_AS:    15428 kB
> PageTables:        408 kB
> VmallocTotal:   114680 kB
> VmallocUsed:       196 kB
> VmallocChunk:   114476 kB
> [root@st-0001 root]#
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

