Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbWJFVHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbWJFVHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWJFVHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:07:25 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:47608 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932631AbWJFVHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:07:24 -0400
Date: Fri, 6 Oct 2006 23:07:22 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Suzuki K P <suzuki@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com
Subject: Re: [RFC] PATCH to fix rescan_partitions to return errors properly - take 2
Message-ID: <20061006210721.GC31233@harddisk-recovery.nl>
References: <452307B4.3050006@in.ibm.com> <20061004130932.GC18800@harddisk-recovery.com> <4523E66B.5090604@in.ibm.com> <20061004170827.GE18800@harddisk-recovery.nl> <4523F16D.5060808@in.ibm.com> <20061005104018.GC7343@harddisk-recovery.nl> <45256BE2.5040702@in.ibm.com> <20061006125336.GA27183@harddisk-recovery.nl> <452695CE.8080901@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452695CE.8080901@in.ibm.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 10:43:42AM -0700, Suzuki K P wrote:
> Erik Mouw wrote:
> >I think it's best not to change the current behaviour and let all
> >partition checkers run, even if one of them failed due to device
> >errors. I wouldn't mind if the behaviour changed like you propose,
> >though.
> >
> At present, the partition checkers doesn't run, if one of the preceeding 
> checker has reported an error ! *But*, some of the checkers doesn't 
> report the I/O error which they came across! So, this may let others 
> run. Thats not we want, right. We would like them to return I/O errors, 
> and and the check_partition should let other partition checkers continue.

Indeed, we want them to behave the same. I.e.: a partition checker
should tell when it encounters an I/O error.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.nl -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
