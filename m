Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTENUv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTENUv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:51:56 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:21404 "HELO
	pengo.systems.pipex.net") by vger.kernel.org with SMTP
	id S262830AbTENUvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:51:54 -0400
From: shaheed <srhaque@iee.org>
To: Robert Love <rml@tech9.net>, Felipe Alfaro Solana <yo@felipe-alfaro.com>
Subject: Re: 2.6 must-fix list, v2
Date: Wed, 14 May 2003 22:01:59 +0100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net> <1052910149.586.3.camel@teapot.felipe-alfaro.com> <1052927975.883.9.camel@icbm>
In-Reply-To: <1052927975.883.9.camel@icbm>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305142201.59912.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 May 2003 4:59 pm, Robert Love wrote:

> You can get exclusive access with mangling the system call, simply by
> having init  bind itself to the non-exclusive processors on boot.
>
> Try it. Every task will then end up on only the non-exclusive
> processors.  Seems a very simple change to me, and one that can be done
> in user-space.
>
> You do not even have to modify init, if you do not want.  Grab
> http://tech9.net/rml/schedutils and put a taskset call in your rc.d

Ah. I think I misread your previous note to me on this...that's why my patch 
modifies init itself (it does not muck with the syscall in any way). I'll try 
this as soon as I have my 2.5 multiprocessor back. BTW: what are the plans 
for getting schedutils (and specifically taskset) into a normal 2.6-based 
distribution? Can I be reasonably sure that this will happen?
