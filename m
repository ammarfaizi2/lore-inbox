Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278124AbRJRURM>; Thu, 18 Oct 2001 16:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278121AbRJRURG>; Thu, 18 Oct 2001 16:17:06 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:21754 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S278120AbRJRUQx>; Thu, 18 Oct 2001 16:16:53 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 18 Oct 2001 14:17:14 -0600
To: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
Cc: "'Andrew Morton'" <akpm@zip.com.au>,
        "Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: Re: Kernel performance in reference to 2.4.5pre1
Message-ID: <20011018141714.M1144@turbolinux.com>
Mail-Followup-To: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>,
	'Andrew Morton' <akpm@zip.com.au>,
	"Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>,
	"HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D57F@xfc01.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D57F@xfc01.fc.hp.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton [mailto:akpm@zip.com.au] wrote:
> SFS is a rather specialised workload, and synchronous NFS exports
> are not a thing which gets a lot of attention.  It could be one
> small, hitherto unnoticed change which caused this performance
> regression.  And it appears that the change occurred between 2.4.5
> and 2.4.7.

Cary, also note that Andrew did some work with ext3 which can greatly
improve the performance of synchronous I/O.  Granted, it doesn't fix
any performance issues in the VM or VFS that may have been introduced,
but if you are looking for good benchmark numbers, give ext3 a try.

Use a large journal to avoid journal flushes for sync I/O.  See:
http://marc.theaimsgroup.com/?l=linux-kernel&m=99650624414465&w=4

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

