Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUCUKdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 05:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbUCUKdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 05:33:18 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:40121 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263629AbUCUKdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 05:33:07 -0500
Message-ID: <405D6F25.1040104@stesmi.com>
Date: Sun, 21 Mar 2004 11:32:05 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Henningsen <kaih@khms.westfalen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
References: <20040311141703.GE3053@luna.mooo.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com> <20040320102241.GK2803@devserv.devel.redhat.com> <405C2AC0.70605@stesmi.com> <95IkrqqXw-B@khms.westfalen.de>
In-Reply-To: <95IkrqqXw-B@khms.westfalen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

>>>>>there is one. Nothing uses it
>>>>>(sysconf() provides this info)
>>>>
>>>>Seems to me that it would be fairly trivial to modify those programs
>>>>(that should use this mechanism but don't) to use it?  So why should
>>>>they be allowed to dictate kernel behaviour?
>>>
>>>
>>>quality of implementation; for example shell scripts that want to do
>>>echo 500 > /proc/sys/foo/bar/something_in_HZ
>>>...
>>>or /etc/sysctl.conf or ...
>>>
>>
>>Then write a simple program already. How hard is it to write a program
>>that does a sysconf() and returns (as ascii of course) just the
>>value of HZ? Then do some trivial calculation off of that.
> 
> 
> How about a slightly more useful utility, like this:
> 
> $ getconf CLK_TCK
> 100
> $ getconf OPEN_MAX
> 1024
> $ getconf PATH_MAX /proc/
> 4096
> $

Yes, yes, yes, I like that one actually.

It does solve the shell script issues and we've never said that things
don't need to adapt to changes before so I don't see why not now.

And that one would be good to have regardless of the HZ issue.

// Stefan
