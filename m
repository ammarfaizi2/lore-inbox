Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267576AbSLFIgv>; Fri, 6 Dec 2002 03:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbSLFIgv>; Fri, 6 Dec 2002 03:36:51 -0500
Received: from mail.scram.de ([195.226.127.117]:6339 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S267576AbSLFIgv>;
	Fri, 6 Dec 2002 03:36:51 -0500
Date: Fri, 6 Dec 2002 09:35:19 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org, <linux-net@vger.kernel.or>
Subject: Re: [patch] fix compile warning and initialization of static tmsisa
In-Reply-To: <20021206011121.GY2544@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0212060927090.32365-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> Please comment on whether it's correct or not and if it's correct
> please apply.

It is broken, as tms_isa_probe() doesn't work on uninitialized dev
structs.

Try either of these for a correct fix:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0211.0/0111.html

http://www.uwsg.iu.edu/hypermail/linux/kernel/0211.1/0537.html
(this one misses the change in Space.c though).

Currently, i can't do any newer patches as module loading is totally
broken on Alpha with later kernel versions.

Cheers,
--jochen

