Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBMWiU>; Tue, 13 Feb 2001 17:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129304AbRBMWiK>; Tue, 13 Feb 2001 17:38:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22796 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129032AbRBMWh7>; Tue, 13 Feb 2001 17:37:59 -0500
Subject: Re: Stale super_blocks in 2.2
To: pauld@egenera.com (Phil Auld)
Date: Tue, 13 Feb 2001 22:38:42 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3A89B693.B0A0ADF9@egenera.com> from "Phil Auld" at Feb 13, 2001 05:34:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14So5t-00038p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That can be a problem for fiber channel devices. I saw some issues with
> invalidate_buffers and page caching discussed in 2.4 space. Any reasons 
> come to mind why I shouldn't call invalidate on the the way down instead 
> (or in addition)?

The I/O completed a few seconds later anyway when bdflush got around to 
writing the data back out. I dont plan to change 2.2. 2.4 doesnt do that
optimisation which is annoying in a few cases and a lot less suprising in
others

