Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289935AbSAKMmo>; Fri, 11 Jan 2002 07:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289940AbSAKMme>; Fri, 11 Jan 2002 07:42:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17668 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289935AbSAKMm1>; Fri, 11 Jan 2002 07:42:27 -0500
Subject: Re: [PATCH] suser to capable changes in char driver
To: bole@falcon.etf.bg.ac.yu (Bosko Radivojevic)
Date: Fri, 11 Jan 2002 12:53:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201110646550.761-100000@falcon.etf.bg.ac.yu> from "Bosko Radivojevic" at Jan 11, 2002 06:50:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P1Bp-0007Ww-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  		 * This tty is already the controlling
>  		 * tty for another session group!
>  		 */
> -		if ((arg == 1) && suser()) {
> +		if ((arg == 1) && capable(CAP_SYS_TTY_CONFIG)) {
>  			/*
>  			 * Steal it away
>  			 */

You can't allow stealing of the controlling tty as TTY_CONFIG, it gives you
direct access to fake input on that console so really wants to be rather
higher.

