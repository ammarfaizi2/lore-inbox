Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264167AbUD0O7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264167AbUD0O7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 10:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUD0O7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 10:59:09 -0400
Received: from smtp09.auna.com ([62.81.186.19]:65171 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S264162AbUD0O7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 10:59:05 -0400
In-Reply-To: <20040427142643.GA10553@merlin.emma.line.org>
References: <200404261532.37860.dj@david-web.co.uk> <20040426161004.GE5430@merlin.emma.line.org> <20040427131941.GC10264@logos.cnet> <20040427142643.GA10553@merlin.emma.line.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6A88E87D-985B-11D8-AA97-000A9585C204@able.es>
Content-Transfer-Encoding: 7bit
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Illegal-Object: Syntax error in From: address found on vger.kernel.org:
	From:	J.A.Magallon<jamagallon@able.es>
				    ^-missing end of mailbox
Subject: Re: Anyone got aic7xxx working with 2.4.26?
Date: Tue, 27 Apr 2004 16:59:00 +0200
From: <jamagallon@able.es>
To: Matthias Andree <matthias.andree@gmx.de>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 abr 2004, at 16:26, Matthias Andree wrote:

> On Tue, 27 Apr 2004, Marcelo Tosatti wrote:
>
>> What is the compile error with 2.4-BK-current?
>
> Well, it used to be one that went away after I typed:
>
> cp .config /tmp
> make distclean
> bk -Ur get -S         # <- this checked out dozens of include files
> mv /tmp/.config .
> make oldconfig dep
> make bzImage modules
>
> The problem was:
>
> (1) glibc-devel (SuSE Linux) installs includes into /usr/include/linux.
>     These are older includes (UTS_RELEASE 2.4.20, LINUX_VERSION_CODE
>     132116).
>
> (2) BK had removed some of the include files in the course of a "bk 
> pull"
>
> (3) "make dep" and the kernel stuff picked up the stale includes from
>     /usr/include/linux instead of /space/BK/linux-2.4/include/...
>

-nostdinc should be mandatory ?

--
J.A. Magallon <jamagallon()able!es>   \          Software is like sex:
werewolf!able!es                       \    It's better when it's free
MacOS X 10.3.3, Build 7F44, Darwin Kernel Version 7.3.0

