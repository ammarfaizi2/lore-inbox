Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278839AbRKIAAQ>; Thu, 8 Nov 2001 19:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278841AbRKIAAG>; Thu, 8 Nov 2001 19:00:06 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:43025 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S278839AbRKHX7s>;
	Thu, 8 Nov 2001 18:59:48 -0500
Date: Fri, 9 Nov 2001 10:59:21 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011109105921.A6822@krispykreme>
In-Reply-To: <Pine.LNX.4.30.0111081700240.1916-100000@mustard.heime.net> <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > Are there any speed difference between hard-linked device drivers and
> > their modular counterparts?
> 
> minimal. a few instructions per IO.

Its worse on some architectures that need to pass through a trampoline
when going between kernel and module (eg ppc). Its even worse on ppc64
at the moment because we have a local TOC per module which needs to be
saved and restored.

Anton
