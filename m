Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132799AbRDDLPN>; Wed, 4 Apr 2001 07:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132798AbRDDLPD>; Wed, 4 Apr 2001 07:15:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15885 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132796AbRDDLOo>; Wed, 4 Apr 2001 07:14:44 -0400
Subject: Re: uninteruptable sleep (D state => load_avrg++)
To: christophe.barbe@lineo.fr (christophe barbe)
Date: Wed, 4 Apr 2001 12:15:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010404094708.A4718@pc8.inup.com> from "christophe barbe" at Apr 04, 2001 09:47:08 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14klGU-0001kB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The file locking use real IO and so when you ask for a lock, if the loc=
> k is already owned, you fall in a D state.

That seems odd. They should be using interruptible sleeps so you can interrupt
the task waiting for the lock, surely.

