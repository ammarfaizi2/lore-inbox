Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291903AbSBNU6d>; Thu, 14 Feb 2002 15:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291898AbSBNU4g>; Thu, 14 Feb 2002 15:56:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18695 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291890AbSBNUzw>; Thu, 14 Feb 2002 15:55:52 -0500
Subject: Re: fsync delays for a long time.
To: akpm@zip.com.au (Andrew Morton)
Date: Thu, 14 Feb 2002 21:09:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        moibenko@fnal.gov (Alexander Moibenko), linux-kernel@vger.kernel.org
In-Reply-To: <3C6C2342.5044B738@zip.com.au> from "Andrew Morton" at Feb 14, 2002 12:51:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bT7y-00017B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > fsync on a very large file is very slow on the 2.2 kernels
> 
> This could very well be due to request allocation starvation.
> fsync is sleeping in __get_request_wait() while bonnie keeps
> on stealing all the requests.

That may amplify it but in the 2.2 case fsync on any sensible sized file
is already horribly performing. It hits databases like solid quite badly
