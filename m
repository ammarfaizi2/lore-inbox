Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264772AbRFSUf1>; Tue, 19 Jun 2001 16:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264773AbRFSUfR>; Tue, 19 Jun 2001 16:35:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22802 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264772AbRFSUfK>; Tue, 19 Jun 2001 16:35:10 -0400
Subject: Re: large offset llseek breaks for device special files on ac series
To: martin.frey@compaq.com
Date: Tue, 19 Jun 2001 21:34:28 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, baettig@scs.ch
In-Reply-To: <014b01c0f8fe$d457a830$0100007f@SCHLEPPDOWN> from "Martin Frey" at Jun 19, 2001 04:31:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CSCi-0006eR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This check should be done only for regular files, e.g. for
> a device special file the test does not make sense.
> Either we change the check or we have to write a llseek
> method for each device driver.

Or we introduce a method for regular files on a file system with size limits.
Now that way around is probablyt much saner, and the check is removed from
the default code

Car to whip up a patch ?
