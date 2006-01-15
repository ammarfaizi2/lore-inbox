Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWAOT1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWAOT1P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWAOT1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:27:15 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:54284 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750807AbWAOT1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:27:14 -0500
Date: Sun, 15 Jan 2006 20:27:11 +0100
From: Willy Tarreau <willy@w.ods.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: X killed
Message-ID: <20060115192711.GO7142@w.ods.org>
References: <43CA883B.2020504@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CA883B.2020504@superbug.demon.co.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 15, 2006 at 05:36:59PM +0000, James Courtier-Dutton wrote:
> Hi,
> 
> I have a python application that kills X. I.e. the X process terminates, 
> and all X programs receive broken links to the display and therefore 
> also exit.
> 
> The problem is, this python application is not supposed to kill 
> anything, so I think it is a bug in X, but I cannot find any way to 
> trace the fault. Even gdb says the application was killed, so exited 
> normally, and results in no back trace.
> 
> Is there any way in Linux to find out who did the "killing" ?

Probably that X was killed because your system encountered an OOM
(out of memory) condition. For instance, if python eats all the
memory, and if you have not set any memory usage limit with ulimit,
then you can get anything killed.

> James

Willy

