Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVH1XUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVH1XUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 19:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVH1XUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 19:20:49 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:262 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750937AbVH1XUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 19:20:49 -0400
Message-ID: <431246CA.4000500@superbug.co.uk>
Date: Mon, 29 Aug 2005 00:20:42 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mateusz Berezecki <mateuszb@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 context switching and posix threads performance question
References: <20050827121158.GA18406@oepkgtn.mshome.net>
In-Reply-To: <20050827121158.GA18406@oepkgtn.mshome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mateusz Berezecki wrote:
> Hello List Readers,
> 
> I would really appreciate any comment on the overall performance of task
> switching with 25 000 threads running on the Linux system. I was asked to work
> on some software which spawns 25 000 threads and I am really worried if
> it will ever work on 2 CPU HP Blade. The kernel was modified to support
> bigger threads amount running (I have no idea how it was done, probably
> just changing hardcoded limits) What is the performance impact of
> so much threads on the overall system performance? Is there any ?
> Wouldn't it be that such application would spend all of its time
> switching contexts ? I'm asking for some kind of an authoritative answer
> quite urgently. What is the optimum thread amount on 2 CPU SMP system
> running Linux ?
> 
> 
> Thank you very much in advance
> Mateusz
> 

You would get much better performance by switching the application to 
use a thread pool using a fixed low number ( about CPU*2 = 4) of worker 
threads.

James

