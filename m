Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266109AbTFWTIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 15:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266110AbTFWTIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 15:08:40 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:65287 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266109AbTFWTIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 15:08:37 -0400
Date: Mon, 23 Jun 2003 15:21:22 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
In-Reply-To: <E19Tbyp-0004mi-00@calista.inka.de>
Message-ID: <Pine.LNX.4.10.10306231515130.28273-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Jun 2003, Bernd Eckenfels wrote:

> Is anybody aware of a journalling nbd, which keeps track of unsynced
> changes, so a fast reintegration is possible?
> 
> Well perhaps this is a property of the md device, instead... hmm. Is there
> such a function available? Could be some left over from snapshot code.

Assuming that you use raid1 over nbd, you could try Peter T Breuer's patches 
for raid1 (called fr1) that allow the use of a bitmap for resyncing. I am 
also currently working on expanding on his patches to make the bitmap 
persistent (stored in a file) and to allow asynchronous writing to the 
"backup" (in this case, nbd) device.

Stay tuned...more details on linux-raid about this...

--
Paul

