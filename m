Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTHQKHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 06:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTHQKHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 06:07:17 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:63761 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263861AbTHQKHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 06:07:17 -0400
Date: Sun, 17 Aug 2003 11:07:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Olaf Hering <olh@suse.de>,
       Paul Mackeras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi proc_info called unconditionally
Message-ID: <20030817110713.A30739@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>,
	Paul Mackeras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030816084409.GA8038@suse.de> <1061053254.10688.6.camel@dhcp23.swansea.linux.org.uk> <20030817080901.GA3754@suse.de> <20030817103914.A26579@infradead.org> <1061114176.21502.11.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061114176.21502.11.camel@dhcp23.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Aug 17, 2003 at 10:56:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 10:56:17AM +0100, Alan Cox wrote:
> It probably should give the driver name and version. Christoph is
> right in the longer term but in the real world people still expect
> /proc/scsi/* to contain at least that info.

/proc/scsi/* is not standardized so even if you add a name no
userspace tool can sanely parse it without knowing all drivers.
sysfs OTOH can do this sanely.

So, no it does not make sense to add anything here for a 2.6 driver.

> Possibly for 2.7.x /proc/scsi/* should become an fs or entirely sysfs

/proc/scsi/ will be optional and marked deprecated with with one of my
next patches and go away in 2.9.

