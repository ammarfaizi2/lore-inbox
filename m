Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSCSSCe>; Tue, 19 Mar 2002 13:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSCSSCX>; Tue, 19 Mar 2002 13:02:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14861 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286311AbSCSSCT>; Tue, 19 Mar 2002 13:02:19 -0500
Subject: Re: setrlimit and RLIM_INFINITY causing fsck failure, 2.4.18
To: pdh@utter.chaos.org.uk (Peter Hartley)
Date: Tue, 19 Mar 2002 18:17:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006701c1cf6d$d9701230$2701230a@electronic> from "Peter Hartley" at Mar 19, 2002 05:45:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nOBK-0008KJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Answer (b) breaks programs that deliberately set a limit of 0x7FFFFFFF, but
> it's less intrusive than answer (a). The patch for (b) is fairly trivial and
> I'll rustle one up if people agree it's the Right Thing.

(b) is a standards violation

> So for my purposes I can fix this by upgrading my compile host to a glibc
> that's built against 2.4.18 headers, but I still reckon there's a kernel bug
> here.

Its a compatibility bug. The original submission when it was changed did
try to address this. Originally its a kernel bug because the standards
always said that it was unsigned

