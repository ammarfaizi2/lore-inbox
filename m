Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315137AbSEHUhB>; Wed, 8 May 2002 16:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315133AbSEHUhA>; Wed, 8 May 2002 16:37:00 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:18639 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315130AbSEHUg6>; Wed, 8 May 2002 16:36:58 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
Date: Wed, 8 May 2002 22:06:15 +0200
Message-Id: <20020508200615.7088@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.10.10205081319400.30697-100000@master.linux-ide.org>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Alan, we talked about this and the driver/hardware has a flaw.
>If you count the total number of single IO operations to check
>status/error et al., it is out right fugly.  Preprocessing will kill us
>like today.

So we can still end up having both

 - The single ops indirected like I first proposed (with maybe the
addition of slow versions but that could be a parameter, and 32 bits
versions)
 - A couple of "apply this taskfile" versions with well known semantics
used only in normal cases for perfs.

Ben.

