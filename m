Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264391AbUD0WtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUD0WtO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbUD0WtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:49:14 -0400
Received: from smtp06.auna.com ([62.81.186.16]:19681 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S264390AbUD0WtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:49:12 -0400
In-Reply-To: <20040427180924.GA22366@merlin.emma.line.org>
References: <200404261532.37860.dj@david-web.co.uk> <20040426161004.GE5430@merlin.emma.line.org> <20040427131941.GC10264@logos.cnet> <20040427142643.GA10553@merlin.emma.line.org> <6A88E87D-985B-11D8-AA97-000A9585C204@able.es> <20040427161314.GA18682@merlin.emma.line.org> <20040427180924.GA22366@merlin.emma.line.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1911B825-989D-11D8-A81A-000A9585C204@able.es>
Content-Transfer-Encoding: 7bit
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Illegal-Object: Syntax error in From: address found on vger.kernel.org:
	From:	J.A.Magallon<jamagallon@able.es>
				    ^-missing end of mailbox
Subject: Re: [PATCH] incomplete dependencies with BK tree (was: Anyone got aic7xxx working with 2.4.26?)
Date: Wed, 28 Apr 2004 00:49:10 +0200
From: <jamagallon@able.es>
To: Matthias Andree <matthias.andree@gmx.de>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 abr 2004, at 20:09, Matthias Andree wrote:

> On Tue, 27 Apr 2004, Matthias Andree wrote:
>
>> On Tue, 27 Apr 2004, J.A.Magallon wrote:
>>
>>> -nostdinc should be mandatory ?
>>
>> Seems to be in use on my machine, looking at what "make" prints.
>
> Given that init wants stdarg.h, -nostdinc is not an option for 
> init/main.c.
>

At least gcc3 has [v][s][n]printf and friends as builtins, and also
has __builtin_va_list,_start,_end, etc, so it looks easy to get rid of 
the
stdarg.h dependency.

Easy way: create stdarg.h in kernel includes with defines to builtins.
Next step: kill printfs from linux/lib, if __builtins support the same
features (ie, kernel printfs do not have any particular % code).

Anybody knows if gcc2.95.3 has this builtins ?

I think gcc builtins are under-used in kernel...

--
J.A. Magallon <jamagallon()able!es>   \          Software is like sex:
werewolf!able!es                       \    It's better when it's free
MacOS X 10.3.3, Build 7F44, Darwin Kernel Version 7.3.0

