Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTHQJ4j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 05:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTHQJ4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 05:56:39 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:65419 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263319AbTHQJ4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 05:56:38 -0400
Subject: Re: scsi proc_info called unconditionally
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Olaf Hering <olh@suse.de>, Paul Mackeras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030817103914.A26579@infradead.org>
References: <20030816084409.GA8038@suse.de>
	 <1061053254.10688.6.camel@dhcp23.swansea.linux.org.uk>
	 <20030817080901.GA3754@suse.de>  <20030817103914.A26579@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061114176.21502.11.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 10:56:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 10:39, Christoph Hellwig wrote:
> No!  proc_info is deprecated in 2.6 and you should not add a new
> implementation.  If you want to expose information to userland
> use sysfs.

It probably should give the driver name and version. Christoph is
right in the longer term but in the real world people still expect
/proc/scsi/* to contain at least that info.

Possibly for 2.7.x /proc/scsi/* should become an fs or entirely sysfs

