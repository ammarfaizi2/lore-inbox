Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSH0HuK>; Tue, 27 Aug 2002 03:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSH0HuK>; Tue, 27 Aug 2002 03:50:10 -0400
Received: from tapu.f00f.org ([66.60.186.129]:25515 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S315337AbSH0HuJ>;
	Tue, 27 Aug 2002 03:50:09 -0400
Date: Tue, 27 Aug 2002 00:54:26 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Zheng Jian-Ming <zjm@cis.nctu.edu.tw>, linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
Message-ID: <20020827075426.GA6696@tapu.f00f.org>
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm> <1030382219.1751.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030382219.1751.14.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 06:16:59PM +0100, Alan Cox wrote:

    It changes the whole semantics of every security test in Linux,
    and breaks most of them totally. Our syscalls know the uid is
    constant during the call

Could we not (eventually) have CLONE_CREDs and then lock using
task->cred->lock or whatever?  Or might there be cases where this will
deadlock?  It does mean set[eu]id will have to wait of other threads
and IO to complete... no matter how long that takes, but other than
might it be reasonable?



  --cw
