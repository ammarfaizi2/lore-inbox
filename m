Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291743AbSBAMf6>; Fri, 1 Feb 2002 07:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291744AbSBAMft>; Fri, 1 Feb 2002 07:35:49 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:2570 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S291743AbSBAMfh>;
	Fri, 1 Feb 2002 07:35:37 -0500
Message-ID: <3C5A85C4.55E9FA38@yahoo.com>
Date: Fri, 01 Feb 2002 07:10:45 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.20 i586)
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        andre@linux-ide.org
Subject: Re: [PATCH] clipped disk reports clipped lba size
In-Reply-To: <UTC200201302012.UAA81755.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

> Some disk types fake LBA at 33.8GB, but allow access past this point.
> Some disks actually give I/O errors past the 33.8GB (when jumpered),
> and a SETMAX command is needed to make the rest accessible.
> 
> Two years ago I wrote a tiny utility setmax that does this.
> If I am not mistaken this stuff is now part of the 2.5 kernel.
> No doubt some of it will eventually be backported to 2.4 / 2.2 / 2.0.
> It is in 2.4.18-pre7-ac1.

Alan has said (quite reasonably) that he is not interested in inclusion
of the big IDE patch that exists for 2.2.x -- however, a minimal cut and 
paste backport from 2.4.x IDE to just support HDIO_DRIVE_CMD_AEB (and thus
support setmax) is only about a 100 line diff which I did a while ago.

If there is any interest in this I can check it still applies cleanly to 
current 2.2 pre kernel and send it along for inclusion.

Paul.



