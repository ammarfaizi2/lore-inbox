Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRB0Ndj>; Tue, 27 Feb 2001 08:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRB0Nd2>; Tue, 27 Feb 2001 08:33:28 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52493 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129259AbRB0NdP>; Tue, 27 Feb 2001 08:33:15 -0500
Subject: Re: increasing the number of file descriptors
To: rsaura@retevision.es
Date: Tue, 27 Feb 2001 13:36:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, whawes@star.net
In-Reply-To: <OFA7D9F891.904FF16B-ONC1256A00.0031BFB0@retevision.es> from "rsaura@retevision.es" at Feb 27, 2001 10:39:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XkIo-0003Pc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>       Is there any /proc interface for increasing the number of file
>       descriptors per process?

No. Use rlimi.

>       Must I recompile? maybe changes must be made to files_struct?

Nope. Its all dynamic except for fd_set size, and you should be using poll()
anyway ;)

