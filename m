Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSH0Pi4>; Tue, 27 Aug 2002 11:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSH0Piz>; Tue, 27 Aug 2002 11:38:55 -0400
Received: from pD9E23A01.dip.t-dialin.net ([217.226.58.1]:697 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316512AbSH0Piz>; Tue, 27 Aug 2002 11:38:55 -0400
Date: Tue, 27 Aug 2002 09:42:27 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Chris Wedgwood <cw@f00f.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thunder from the hill <thunder@lightweight.ods.org>,
       Zheng Jian-Ming <zjm@cis.nctu.edu.tw>, <linux-kernel@vger.kernel.org>
Subject: Re: problems with changing UID/GID
In-Reply-To: <20020827075426.GA6696@tapu.f00f.org>
Message-ID: <Pine.LNX.4.44.0208270940350.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Aug 2002, Chris Wedgwood wrote:
> Could we not (eventually) have CLONE_CREDs and then lock using
> task->cred->lock or whatever?  Or might there be cases where this will
> deadlock?  It does mean set[eu]id will have to wait of other threads
> and IO to complete... no matter how long that takes, but other than
> might it be reasonable?

I don't think this is cool. I mean, think of how many times we use it, who 
will eat the overhead? Basically everyone. (And BTW, if we can't even 
afford one lock per module, how could we efford one jock per job? There 
are definitely more.)

Takes time and space...

Care to comment?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

