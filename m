Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbTGOOzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268253AbTGOOzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:55:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52623 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268231AbTGOOzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:55:09 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Partitioned loop device..
Date: Tue, 15 Jul 2003 10:01:44 -0500
User-Agent: KMail/1.5
References: <E1B7C89B8DCB084C809A22D7FEB90B384E34B4@frodo.avalon.ru>
In-Reply-To: <E1B7C89B8DCB084C809A22D7FEB90B384E34B4@frodo.avalon.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151001.44218.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 July 2003 03:46, Dimitry V. Ketov wrote:
> Hello,
> 	Is there any (un)official patch for current stable (or
> development) kernel that makes loop device partitioned? I found one on
> the ftp://ftp.hq.nasa.gov/pub/ig/ccd/enhanced_loopback/ (it contains
> port of Scyld's partition enhancements), but it seems still needs a fix.
> In general I plan to use partitioned loop device to simulate real disks
> in linux labs, possibly with a help from Stephen Tweedie's testdrive
> fault simulator. I just wonder if partitionable/faultable loop device
> planned in the future official kernels, or it will be better to write a
> separate 'simulated disk' driver???
>
> Thanks in advance,
> Dimitry.

You can already use Device-Mapper to create "partitions" on your loop devices, 
so there's not much of a reason to add partitioning support to the loop 
driver itself. There are a variety of tools you can use to set them up: EVMS, 
LVM2, dmsetup, and I think there is/was a simple partitioning tool that uses 
DM (dmpartx?). 

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

