Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSH0TEF>; Tue, 27 Aug 2002 15:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSH0TEF>; Tue, 27 Aug 2002 15:04:05 -0400
Received: from pD9E23A01.dip.t-dialin.net ([217.226.58.1]:64186 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316788AbSH0TEE>; Tue, 27 Aug 2002 15:04:04 -0400
Date: Tue, 27 Aug 2002 13:08:04 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Chris Wedgwood <cw@f00f.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zheng Jian-Ming <zjm@cis.nctu.edu.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with changing UID/GID
In-Reply-To: <20020827181207.GA8578@tapu.f00f.org>
Message-ID: <Pine.LNX.4.44.0208271304250.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Aug 2002, Chris Wedgwood wrote:
> On Tue, Aug 27, 2002 at 09:42:27AM -0600, Thunder from the hill wrote:
> 
>     I don't think this is cool. I mean, think of how many times we use
>     it, who will eat the overhead?
> 
> We use it almost never... a few times per process at most.  And the
> overhead will be nonexistent except in cases where the caller has to
> wait on the lock --- and in those cases it seems totally reasonable they
> *should* have to wait.

And how do you protect a caller from having to wait for the lock? You'd 
need a lock count here, where you can only change the credentials when the 
count is zero. But when will that ever be?

And btw, the count bumping/downing does cost. We need to do that sensibly.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

