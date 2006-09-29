Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWI2INE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWI2INE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWI2INE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:13:04 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:28721 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751671AbWI2INB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:13:01 -0400
Date: Fri, 29 Sep 2006 10:13:27 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>,
       Patrick Mochel <mochel@infinity.powertie.org>
Subject: Re: [PATCH] Don't leak 'old_class_name' in
 drivers/base/core.c::device_rename()
Message-ID: <20060929101327.1ae1b793@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <200609282356.01962.jesper.juhl@gmail.com>
References: <200609282356.01962.jesper.juhl@gmail.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 23:56:01 +0200,
Jesper Juhl <jesper.juhl@gmail.com> wrote:

> If kmalloc() fails to allocate space for 'old_symlink_name' in
> drivers/base/core.c::device_rename(), then we'll leak 'old_class_name'.

driver-core-fixes-check-for-return-value-of-sysfs_create_link.patch (in
-mm) already fixes this (amongst other things).

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
