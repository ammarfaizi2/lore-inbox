Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbUKHTe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbUKHTe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUKHTdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:33:09 -0500
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:1938 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S261214AbUKHTbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:31:10 -0500
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Date: Mon, 8 Nov 2004 11:31:08 -0800
User-Agent: KMail/1.7.1
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de> <Pine.LNX.4.61.0411081308320.5968@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0411081308320.5968@chaos.analogic.com>
Cc: linux-os@analogic.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411081131.08857.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 November 2004 10:22, linux-os wrote:
> Hmmm, how does it get the correct return-value and type?
Presumably it does it only for sprintf() calls where the return value is 
ignored.

> I don't 
> think that a compiler is allowed to change the function(s) called.
GCC is making the assumption that the functions it's replacing comply with the 
C standard. I personally don't think that's too insane, especially since it 
can be turned off (see below).

> If gcc is doing this now, there are many potential problems and
> it needs to be fixed. For instance, one can't qualify a
> 'C' runtime library and then have a compiler decide that it's
> not going to call the pre-qualified function.
-fno-builtin

-Ryan
