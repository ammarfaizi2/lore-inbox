Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbTBDN7T>; Tue, 4 Feb 2003 08:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTBDN7S>; Tue, 4 Feb 2003 08:59:18 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:15025 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267264AbTBDN7R> convert rfc822-to-8bit; Tue, 4 Feb 2003 08:59:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Axel Kittenberger <Axel.Kittenberger@maxxio.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: oom_kill
Date: Tue, 4 Feb 2003 08:07:03 -0600
User-Agent: KMail/1.4.1
Cc: riel@nl.linux.org
References: <200302041332.05096.Axel.Kittenberger@maxxio.com>
In-Reply-To: <200302041332.05096.Axel.Kittenberger@maxxio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302040807.03214.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 February 2003 06:32 am, Axel Kittenberger wrote:
> A small patch to discuss, it's about killing an process in an out-of-memory
> condition. First from the code I don't see any prohibition that it kills
> init, if reaches maximum badness points, don't think thats something
> anybody anytime wants. Sure for desktop systems this very unlikely to ever
> occur, but for small embedded systems that could happen.

ok.

> Second proposal is to give processes that are direct childs from init a
> special bonus, normally that are those we don't want to get killed. They
> are either important or get respawned eitherway creating an endless oom
> condition loop when killing them.

And what about processes that get reparented to init? These could be causing
the OOM. I didn't think that the p_ptr was null when reparenting happens.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
