Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbRFLQbg>; Tue, 12 Jun 2001 12:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262626AbRFLQb0>; Tue, 12 Jun 2001 12:31:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35082 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262582AbRFLQbT>; Tue, 12 Jun 2001 12:31:19 -0400
Subject: Re: Any limitations on bigmem usage?
To: mnelson@dynatec.com (Matt Nelson)
Date: Tue, 12 Jun 2001 17:29:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B255FC1.90501@dynatec.com> from "Matt Nelson" at Jun 11, 2001 05:18:09 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159r2Z-0001b4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Specifically, is there anything to prevent me from malloc()ing 6GB of memory, 
> then accessing that memory as I would any other buffer?  FYI, the application

X86 has no nice way to address over 4Gb of RAM. You can do paging games with
multiple banks and shmat (ie like using DOS expanded ram but with bigger
pieces).

> I've been eyeing an 8-way Intel box with gobs of memory, but if there are subtle 
> issues with using that much memory, I need to know now.

If your algorithm can work well with say 2Gb windows on the data and only change
window evey so often (in computing terms) then it should be ok, if its access
is random you need to look at a 64bit box like an Alpha, Sparc64 or eventually
IA64

