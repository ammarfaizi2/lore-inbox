Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSH0T4G>; Tue, 27 Aug 2002 15:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSH0T4G>; Tue, 27 Aug 2002 15:56:06 -0400
Received: from tapu.f00f.org ([66.60.186.129]:38579 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S317017AbSH0T4F>;
	Tue, 27 Aug 2002 15:56:05 -0400
Date: Tue, 27 Aug 2002 13:00:25 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zheng Jian-Ming <zjm@cis.nctu.edu.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with changing UID/GID
Message-ID: <20020827200025.GA8985@tapu.f00f.org>
References: <20020827181207.GA8578@tapu.f00f.org> <Pine.LNX.4.44.0208271304250.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208271304250.3234-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 01:08:04PM -0600, Thunder from the hill wrote:

    And how do you protect a caller from having to wait for the lock?

You don't.  If they have to wait, then they wait.

    You'd need a lock count here, where you can only change the
    credentials when the count is zero. But when will that ever be?

It depends... for most non-threaded applications, immediately... for
threaded applications with lots of (day) disk IO, it could be
indefinite.

    And btw, the count bumping/downing does cost.

Almost immeasurable.  [sg]et[eu]id doesn't get called that often.



  --cw
