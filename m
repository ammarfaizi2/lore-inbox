Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136664AbREJORf>; Thu, 10 May 2001 10:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136663AbREJOR0>; Thu, 10 May 2001 10:17:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5904 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136664AbREJORP>; Thu, 10 May 2001 10:17:15 -0400
Subject: Re: IDE DMA timeouts and reiserfs stability
To: tomlins@cam.org (Ed Tomlinson)
Date: Thu, 10 May 2001 15:20:31 +0100 (BST)
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        andre@linux-ide.org
In-Reply-To: <01050923423500.00777@oscar> from "Ed Tomlinson" at May 09, 2001 11:42:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xrIu-0004si-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> DMA timeouts occur twice.  Both times corrupted my fs.  While this is not
> ideal, its not unexpected as things stand now.  I have seen at least three 
> other reports on lkml about errors of this type - suspect that 2.4's ide 
> is a little fragile in some corner cases...

The DMA handling retry code seems to be rather broken. We also have unexplained
traces of IDE recursing which would corrupt the sg tables and make rather
a mess of the IO

So yes, there is some debugging work needed on the current IDE layer

