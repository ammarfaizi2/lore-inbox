Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263484AbUEGMj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUEGMj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 08:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbUEGMj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 08:39:59 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:50185 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S263484AbUEGMj6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 08:39:58 -0400
Date: Fri, 7 May 2004 14:42:17 +0200 (CEST)
Message-Id: <200405071242.i47CgHPE027360@zone3.gcu-squad.org>
To: greg@kroah.com, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Fix memory leaks in w83781d and asb100
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.12 (On: webmail.gcu.info)
In-Reply-To: <20040505221804.GE29885@kroah.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: vsu@altlinux.ru, "Mark M. Hoffman" <mhoffman@lightlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Greg, please apply if it looks good to you. Sorry for introducing the
>> leak in the first place...
>
>Looks a bit odd, but ok.

Odd? Why that? If you can think of something better, just tell me. The
only other way I could think of was faking subclient's private data so
that it points to the i2c_client structure itself. That way, freeing
i2c_get_clientdata(client) would always work. However, I was fearing
some side effect. Maybe the code makes use of the NULL data for
remembering which clients are subclients at some point? I think I
remember that the 2.4 drivers did, but maybe the 2.6 ones don't. I can
take another look and propose that different solution if you want.

Thanks.
