Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRB0NwJ>; Tue, 27 Feb 2001 08:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRB0Nv7>; Tue, 27 Feb 2001 08:51:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129346AbRB0Nvz>; Tue, 27 Feb 2001 08:51:55 -0500
Subject: Re: binfmt_script and ^M
To: irt@cistron.nl (Ivo Timmermans)
Date: Tue, 27 Feb 2001 13:54:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010227144746.B25058@cistron.nl> from "Ivo Timmermans" at Feb 27, 2001 02:47:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XkaQ-0003Sa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > (\r\n), Linux 2.4.2 can't find an interpreter because it doesn't
> > > recognize the \r.  The following patch should fix this (untested).
> > 
> > Fix the script. The kernel expects a specific format
> 
> For what reason?  Is it a standard to not allow it, or does it break
> other things?

The line terminator is \n so if you have

#!/usr/bin/perl\r\n

Then the command to run is "/usr/bin/perl\r" - and \r is a valid file name
component

