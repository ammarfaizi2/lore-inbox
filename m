Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWAFQAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWAFQAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWAFQAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:00:18 -0500
Received: from [81.2.110.250] ([81.2.110.250]:8418 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751026AbWAFQAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:00:17 -0500
Subject: RE: RAID controller safety
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060106151855.63846.qmail@web34102.mail.mud.yahoo.com>
References: <20060106151855.63846.qmail@web34102.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Jan 2006 16:02:35 +0000
Message-Id: <1136563355.30498.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-06 at 07:18 -0800, Kenny Simpson wrote:
> Won't the i2o_block driver use i2o_block_device_flush to flush the devices' cache (by issuing a
> I2O_CMD_BLOCK_CFLUSH), or this this function used in some very different context?


I'm out of date. It was originally used on the last close of removable
media and to work around some promise bugs. Markus Lidel has indeed
added the relevant functions and hooks to let the block layer use it for
barriers

Alan

