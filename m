Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbVKPWjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbVKPWjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbVKPWjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:39:39 -0500
Received: from web34112.mail.mud.yahoo.com ([66.163.178.110]:36519 "HELO
	web34112.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030539AbVKPWji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:39:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JromwVJla0PtNT+FvBswCrO8+TlC3zPykpZpr1Wd+Rsejb9ZLpAYwQNHl/bNi5mOcnvYe7vQ15SZbuuc6w0ZhvJm36Nhdck+h366BQDZVEq3Gh504Kn5SxMyv1UtZMafcMMFVXkCgSUH+ChfZIHUDKUl7MnG+HPxi/zvZvkyC9U=  ;
Message-ID: <20051116223937.28115.qmail@web34112.mail.mud.yahoo.com>
Date: Wed, 16 Nov 2005 14:39:37 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1132178234.8811.64.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> I'm getting lost here. Please could you spell out the testcases that are
> not working.

I've redone my test cases and have confirmed that O_DIRECT with pwrite64 triggers the bad
condition.

The cases that are fine are:
  pwrite64
  ftruncate with O_DIRECT
  ftruncate

Also, when the system is in this state, if I try to 'ls' the file,
the 'ls' process becomes stuck in state D in sync_page.  stracing the 'ls'
shows it is in a call to stat64.

-Kenny



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
