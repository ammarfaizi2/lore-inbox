Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422790AbWI2UVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422790AbWI2UVU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422800AbWI2UVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:21:20 -0400
Received: from lixom.net ([66.141.50.11]:31431 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1422790AbWI2UVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:21:19 -0400
Date: Fri, 29 Sep 2006 15:20:40 -0500
From: Olof Johansson <olof@lixom.net>
To: Timur Tabi <timur@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: SATA: "unknown partition table" error, fdisk can't fix, works
 in	2.6.13
Message-ID: <20060929152040.6b7c4e3c@localhost.localdomain>
In-Reply-To: <451D7DE8.8020504@freescale.com>
References: <451D7DE8.8020504@freescale.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 15:11:20 -0500 Timur Tabi <timur@freescale.com> wrote:

> I have a SATA drive attached to a PowerPC 8349E board, using the SIL 3114 controller.  I'm running the latest code from Paul Mackerras (PowerPC maintainer) (2.6.18-blabla).
> 
> I'm experiencing a number of I/O errors with the SATA drive.  fdisk can see the partition table, but when I issue the "w" command, I get this output:
> 
> The odd thing is that this works in 2.6.13, so something is broken.  I don't know if it's a bug in the sata_sil driver, or a configuration issue.  Can anyone help?
> 

Do you use MSDOS or MAC partition (or other) type? Make sure you have
the one you use in the config.

It looks like the arch/powerpc/configs/mpc83* defconfigs enable neither.


-Olof
