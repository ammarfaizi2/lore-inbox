Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267999AbRHFLvV>; Mon, 6 Aug 2001 07:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268001AbRHFLvM>; Mon, 6 Aug 2001 07:51:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56336 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267997AbRHFLuy>; Mon, 6 Aug 2001 07:50:54 -0400
Subject: Re: /proc/<n>/maps getting _VERY_ long
To: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 6 Aug 2001 12:52:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9kkr7r$mov$1@cesium.transmeta.com> from "H. Peter Anvin" at Aug 05, 2001 06:17:47 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Tiw1-0000oU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you count applications which selectively mprotect()'s memory (to
> trap SIGSEGV and maintain coherency with on-disk data structures) as
> "broken applications"?
> 
> Such applications *can* use large amounts of mprotect()'s.

That would explain a lot since mprotect currently doesn't seem to do
merging, and worse it also seems to not be doing rlimit checking right
