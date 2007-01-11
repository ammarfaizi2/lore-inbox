Return-Path: <linux-kernel-owner+w=401wt.eu-S1750858AbXAKQsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbXAKQsJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbXAKQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:48:09 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46047 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbXAKQsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:48:06 -0500
Date: Thu, 11 Jan 2007 08:47:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Jean Delvare <khali@linux-fr.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
In-Reply-To: <Pine.LNX.4.64.0701111330400.14457@scrub.home>
Message-ID: <Pine.LNX.4.64.0701110846250.3594@woody.osdl.org>
References: <20070109102057.c684cc78.khali@linux-fr.org>
 <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101426400.14458@scrub.home> <20070110181053.3b3632a8.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org> <Pine.LNX.4.64.0701111330400.14457@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2007, Roman Zippel wrote:
> 
> Unless the SuSE tool is completely stupid, it should actually work:
> 
> $ strings vmlinux | grep "Linux version"
> Linux version 2.6.20-rc3-git7 (roman@squid) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #7 SMP Wed Jan 10 14:20:10 CET 2007

How about you do

	git grep '".*Linux version .*"'

instead, and realize that it depends on your configuration option. Notably 
CIFS.

In short: __init is actually a real *BUG*.

		Linus
