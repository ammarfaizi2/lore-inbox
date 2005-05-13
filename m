Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVEMQNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVEMQNY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 12:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVEMQNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 12:13:23 -0400
Received: from [81.2.110.250] ([81.2.110.250]:39112 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262411AbVEMQNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 12:13:15 -0400
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116000686.1448.486.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 May 2005 17:11:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are bigger problems with the Unix clock than that already. Old
Unix used GMT, newer Unixen use UTC so the same timeval is several
seconds out between very old and modern systems.

Our 64bit time_t in the 64bit kernels seems to work well in testing too
(except older SuSE which segfaulted but thats just a libc glitch). The
next time Linux seems to fall apart is 2800AD, although the CMOS hits
problems rather earlier and would need a new driver/definition if still
used. Feb 29th 2800 seems to be when all hell breaks loose and thats
*not* *our* *fault* but because time hasn't been standardised
sufficiently at this point.

2038 is more likely to be boom time for old long running embedded
systems, machinery and control circuits than Linux.

Alan

