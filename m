Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282940AbRLDJVz>; Tue, 4 Dec 2001 04:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282948AbRLDJVQ>; Tue, 4 Dec 2001 04:21:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39952 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282940AbRLDJVJ>; Tue, 4 Dec 2001 04:21:09 -0500
Subject: Re: possible to do non-blocking write to NFS?
To: cfriesen@nortelnetworks.com (Christopher Friesen)
Date: Tue, 4 Dec 2001 09:30:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C0BA20F.946E0F1B@nortelnetworks.com> from "Christopher Friesen" at Dec 03, 2001 11:02:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BBts-0001OS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any way to write to an NFS-mounted filesystem in a way that will avoid
> all of the NFS retries?  Basically I want to try a write, and if the server is
> not accessable I want to return immediately with an error code.

Mount the file system soft. Remember that the error you see may well be on
fsync or close. Also it'll still take some time to decide the other end is
dead not just slow

Alan
