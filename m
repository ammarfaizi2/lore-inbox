Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031350AbWFOU5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031350AbWFOU5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 16:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031358AbWFOU5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 16:57:20 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:26117 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1031350AbWFOU5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 16:57:19 -0400
Date: Thu, 15 Jun 2006 22:57:23 +0200
From: Jean Delvare <khali@linux-fr.org>
To: linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>
Subject: i2c-algo-ite and i2c-ite planned for removal
Message-Id: <20060615225723.012c82be.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I noticed today that we have an i2c bus driver named i2c-ite,
supposedly useful on some MIPS systems which have an ITE8172 chip,
which doesn't compile. It is based on an i2c algorithm driver named
i2c-algo-ite, which doesn't compile either, due to some changes made to
the i2c core which weren't properly reflected there. Going back trough
the versions, I found that the bus driver was previously named
i2c-adap-ite, and was introduced in 2.4.10. And I don't think it even
compiled back then either, as it uses a structure (iic_ite) which isn't
defined anywhere.

So basically we have two drivers in the kernel tree for 5 years or so,
which never were usable, and nobody seemed to care. It's about time to
get rid of these 1296 lines of code, don't you think? So, unless someone
volunteers to take care of these drivers, or otherwise has a very
strong reason to object, I'm going to delete them from the tree soon.

Thanks,
-- 
Jean Delvare
