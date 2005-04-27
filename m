Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVD0Roq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVD0Roq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVD0Roc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:44:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:65477 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261867AbVD0RoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:44:14 -0400
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for
	SG_IO etc.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Kai.Makisara@kolumbus.fi,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org
In-Reply-To: <20050427171649.GG3195@kroah.com>
References: <20050427171446.GA3195@kroah.com>
	 <20050427171649.GG3195@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114619928.18809.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Apr 2005 17:38:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-04-27 at 18:16, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.

This patch is just wrong on so many different levels its hard to know
where to begin.

1. The auth for arbitary commands is CAP_SYS_RAWIO
2. "The SCSI command permissions were discussed widely on the linux
lists but this did not result in any useful refinement of the
permissions." - this is false. The process was refined, a table setup
was added and debugged. Someone even wrote an fs for managing it that is
not yet merged. Perhaps the patch author would care to re-read the
archives and submit a new patch if one is even needed
3. Pleas explain *what* the specific consistency problems are

And then please fix the same mess in 12rc.

Alan

