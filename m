Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbUK3Rep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbUK3Rep (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUK3Rep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:34:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:17300 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262207AbUK3Ren (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:34:43 -0500
Date: Tue, 30 Nov 2004 18:34:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Walking all the physical memory in an x86 system
In-Reply-To: <41ACADD3.2030206@draigBrady.com>
Message-ID: <Pine.LNX.4.53.0411301832510.11795@yvahk01.tjqt.qr>
References: <C863B68032DED14E8EBA9F71EB8FE4C2057CA977@azsmsx406>
 <Pine.LNX.4.53.0411301711140.25731@yvahk01.tjqt.qr> <41ACADD3.2030206@draigBrady.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> what have They done with /dev/mem? ... one once could access e.g.
>> position 0x400 of /dev/mem (by seeking) and then read the LPT port value.
>
>Are you thinking of /dev/port ?

No, I was thinking of:

	unsigned short p;
	fd = open("/dev/mem", O_RDONLY | O_BINARY);
	lseek(fd, 0x400, SEEK_SET);
	read(fd, &p, 2);


Jan Engelhardt
-- 
ENOSPC
