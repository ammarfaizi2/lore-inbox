Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTAJFGI>; Fri, 10 Jan 2003 00:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbTAJFGH>; Fri, 10 Jan 2003 00:06:07 -0500
Received: from adsl-66-112-90-25-rb.spt.centurytel.net ([66.112.90.25]:4992
	"EHLO carthage") by vger.kernel.org with ESMTP id <S262807AbTAJFGG>;
	Fri, 10 Jan 2003 00:06:06 -0500
Date: Thu, 9 Jan 2003 23:14:50 -0600
From: James Curbo <phoenix@sandwich.net>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA timeouts on Promise 20267 IDE card
Message-ID: <20030110051450.GC411@carthage>
Reply-To: James Curbo <phoenix@sandwich.net>
References: <233C89823A37714D95B1A891DE3BCE5202AB1B6D@xch-a.win.zambeel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1B6D@xch-a.win.zambeel.com>
User-Agent: Mutt/1.4i
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 09, Manish Lachwani wrote:
> Can you also get the SMART data from the drives using smartctl? Also, it
> looks like the errors are happening on both the drives. Which UDMA mode are
> you operating in?
> 
> Thanks
> Manish

UDMA 5 for both of them. Here is the smartctl data:

carthage:/home/james# smartctl -v /dev/hda
Vendor Specific SMART Attributes with Thresholds:
Revision Number: 16
Attribute                    Flag     Value Worst Threshold Raw Value
(  1)Raw Read Error Rate     0x000b   200   199   051       0
(  3)Spin Up Time            0x0007   102   095   021       3733
(  4)Start Stop Count        0x0032   100   100   040       419
(  5)Reallocated Sector Ct   0x0032   160   160   112       160
(  7)Seek Error Rate         0x000b   100   253   051       0
(  9)Power On Hours          0x0032   079   079   000       15858
( 10)Spin Retry Count        0x0013   100   099   051       2
( 11)Calibration Retry Count 0x0013   100   100   051       0
( 12)Power Cycle Count       0x0032   100   100   000       358
(196)Reallocated Event Count 0x0032   126   126   000       74
(197)Current Pending Sector  0x0012   200   200   000       1
(198)Offline Uncorrectable   0x0012   200   200   000       0
(199)UDMA CRC Error Count    0x000a   200   253   000       65884
(200)Unknown Attribute       0x0009   200   199   051       1

carthage:/home/james# smartctl -v /dev/hdc
Vendor Specific SMART Attributes with Thresholds:
Revision Number: 16
Attribute                    Flag     Value Worst Threshold Raw Value
(  1)Raw Read Error Rate     0x000b   200   200   051       0
(  3)Spin Up Time            0x0007   101   093   021       2300
(  4)Start Stop Count        0x0032   100   100   040       96
(  5)Reallocated Sector Ct   0x0033   200   200   140       0
(  7)Seek Error Rate         0x000b   200   200   051       0
(  9)Power On Hours          0x0032   096   096   000       3325
( 10)Spin Retry Count        0x0013   100   253   051       0
( 11)Calibration Retry Count 0x0013   100   253   051       0
( 12)Power Cycle Count       0x0032   100   100   000       93
(196)Reallocated Event Count 0x0032   200   200   000       0
(197)Current Pending Sector  0x0012   200   200   000       0
(198)Offline Uncorrectable   0x0012   200   200   000       0
(199)UDMA CRC Error Count    0x000a   200   253   000       0
(200)Unknown Attribute       0x0009   200   200   051       0



-- 
James Curbo <hannibal@adtrw.org> <phoenix@sandwich.net>
http://www.adtrw.org/blogs/hannibal/
