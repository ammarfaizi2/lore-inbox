Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWCGPA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWCGPA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWCGPA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:00:58 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35970 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750759AbWCGPA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:00:57 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <440D9F8E.7050402@s5r6.in-berlin.de>
Date: Tue, 07 Mar 2006 15:58:22 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Bodo Eggert <7eggert@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Move SG_GET_SCSI_ID from sg to scsi
References: <Pine.LNX.4.58.0603061133070.2997@be1.lrz> <440C8E60.6020005@torque.net>
In-Reply-To: <440C8E60.6020005@torque.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.764) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> In linux there is also a move away from the host_number,
> channel_number, target_identifier and LUN tuple used
> traditionally by many Unix SCSI subsystems (most do not
> have the second component: channel_number). At least the
> LUN is not controversial (as long as it is 8 byte!). The
> target_identifier is actually transport dependent (but
> could just be a simple enumeration). The host_number is
> typically an enumeration over PCI addresses but some
> other type of computer buses (e.g. microchannel) could be
> involved.

For some transports, not only the channel but also the Scsi_Host is 
meaningless. Such transports deal only with targets and logical units. 
This includes all multi-protocol + multi-bus or network infrastructures 
such as iSCSI, USB, IEEE 1394.
-- 
Stefan Richter
-=====-=-==- --== --===
http://arcgraph.de/sr/
