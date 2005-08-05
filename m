Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVHEOi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVHEOi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVHEOiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:38:17 -0400
Received: from dvhart.com ([64.146.134.43]:20864 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261759AbVHEOgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:36:11 -0400
Date: Fri, 05 Aug 2005 07:36:04 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       bugme-daemon@kernel-bugs.osdl.org
Subject: Re: [Bugme-new] [Bug 5003] New: Problem with symbios driver on recent	-mm trees
Message-ID: <179280000.1123252564@[10.10.2.4]>
In-Reply-To: <1123251892.5003.6.camel@mulgrave>
References: <135040000.1123216397@[10.10.2.4]> <20050804233927.2d3abb16.akpm@osdl.org> <1123251892.5003.6.camel@mulgrave>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--James Bottomley <James.Bottomley@SteelEye.com> wrote (on Friday, August 05, 2005 09:24:52 -0500):

> On Thu, 2005-08-04 at 23:39 -0700, Andrew Morton wrote:
>> James, could some of the scsi core rework have caused this?
> 
> Well, I don't think so.  The error below:
> 
>> > sdc: Unit Not Ready, sense:
>> > : Current: sense key=0x0
>> >     ASC=0x0 ASCQ=0x0
>> >  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>> > Device  not ready.
>> >  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>> > Device  not ready.
>> >  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>> > Device  not ready.
>> > sdc : READ CAPACITY failed.
>> > sdc : status=1, message=00, host=0, driver=08 
>> > sd: Current: sense key=0x0
>> >     ASC=0x0 ASCQ=0x0
> 
> Is coming from the disk not the symbios driver ... I think you have a
> disk failure.

Howcome it works on all mainline kernels, and not -mm then? ;-)
Did we fix an error path to detect failures, maybe?

M.
