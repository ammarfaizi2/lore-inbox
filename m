Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312031AbSDAQAz>; Mon, 1 Apr 2002 11:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311948AbSDAQAp>; Mon, 1 Apr 2002 11:00:45 -0500
Received: from dial-up-2.energonet.ru ([195.16.109.101]:10880 "EHLO
	dial-up-2.energonet.ru") by vger.kernel.org with ESMTP
	id <S311940AbSDAQAb>; Mon, 1 Apr 2002 11:00:31 -0500
Date: Mon, 25 Mar 2002 19:30:46 +0000
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Sheduling + forkbomb
Message-ID: <20020325193046.GA4578@bk.ru>
Mail-Followup-To: =?koi8-r?B?0JzQsNC60YHQuNC8INCb0LDQv9GI0LjQvQ==?= <ertzog@bk.ru>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux dial-up-2.energonet.ru 2.4.18 
From: Max <ertzog@bk.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't it strange, that a simple fork-bomb, like a command to sh:
f(){ f|f& }; f
can get machine down. I've tried several times this thing, changing
ulimit. (I've set a limit to user processes - 1000 ).
The kernel didn't want to reply even on Alt+SysRq+H.
Only Alt+SysRq+B could help. Of course, Ctrl+Alt+Del couldn't help
because init couldn't spawn processes to procees reboot scripts.

My kernel is 2.4.18

Best regards.
