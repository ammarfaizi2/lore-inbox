Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263326AbTHVTZm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTHVTZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:25:42 -0400
Received: from smtp2.brturbo.com ([200.199.201.158]:36841 "EHLO
	smtp2.brturbo.com") by vger.kernel.org with ESMTP id S263326AbTHVTZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:25:40 -0400
Message-ID: <3F466E2A.8040905@PolesApart.wox.org>
Date: Fri, 22 Aug 2003 16:25:30 -0300
From: Alexandre Pereira Nunes <alex@PolesApart.wox.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Doubt: core not dumped when binary give up root privileges.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I wrote a program which runs with uid 0, but later give up root privs by 
calling setreuid(x, x) where x is an unprivileged user.
Before doing that, it chdirs to a directory owned by that unprivileged 
user, with mode 700.

The program explicitly sets RLIMIT_CORE to RLIM_INFINITY when still 
running with uid 0.

If instead of calling the program as root, I call it from the non-priv 
uid in question, if it crashes, it dumps core on the mentioned dir. 
That's the desired behaviour, since I can then take the core and debug. 
But if I run it as root (in fact, I would have to), and it crashes (or 
is forced to ,by means of kill -SEGV), after it gives up root 
credentials, it won't leave a core dump file, which in turn means I 
cannot debug it later.

Any ideas?


Please CC-me since I'm not subscribed.

Thanks,

Alexandre

