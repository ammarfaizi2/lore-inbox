Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVFVAAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVFVAAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVFUX5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:57:20 -0400
Received: from mail.dvmed.net ([216.237.124.58]:5546 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262406AbVFUXyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 19:54:52 -0400
Message-ID: <42B8A8CA.9040804@pobox.com>
Date: Tue, 21 Jun 2005 19:54:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
References: <Pine.LNX.4.58.0506211304320.2915@skynet> <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com> <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org> <42B84E20.7010100@pobox.com> <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org> <42B8542A.9020700@pobox.com> <Pine.LNX.4.58.0506211103370.2268@ppc970.osdl.org> <42B859B4.5060209@pobox.com> <Pine.LNX.4.58.0506211124310.2268@ppc970.osdl.org> <42B8A82E.4020207@pobox.com>
In-Reply-To: <42B8A82E.4020207@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Linus Torvalds wrote:
> 
>>
>> On Tue, 21 Jun 2005, Jeff Garzik wrote:
>>
>>> If git-checkout-script switches the .git/HEAD symlink properly, 
>>> rather than updating the symlink target's contents, then my 
>>> git-switch-tree script can just go away :)
>>
>>
>>
>> Well, you should test it. I sure didn't ;)
> 
> 
> hmmm, I tried
> 
>     git checkout -f ncq
> 
> on libata-dev.git and it didn't seem to switch the symlink.

It does seem to hit the final branch in the script:

> [jgarzik@pretzel libata-dev]$ sh -x /usr/local/bin/git-checkout-script -f ncq
> + : .git
> ++ git-rev-parse HEAD
> + old=7df551254add79a445d2e47e8f849cef8fee6e38
> + new=
> + force=
> + branch=
> + '[' 2 '!=' 0 ']'
> + arg=-f
> + shift
> + case "$arg" in
> + force=1
> + i=1
> + '[' 1 '!=' 0 ']'
> + arg=ncq
> + shift
> + case "$arg" in
> ++ git-rev-parse ncq
> + rev=d032ec9048ff82a704b96b93cfd6f2e8e3a06b19
> + '[' -z d032ec9048ff82a704b96b93cfd6f2e8e3a06b19 ']'
> + '[' '' ']'
> + new=d032ec9048ff82a704b96b93cfd6f2e8e3a06b19
> + '[' -f .git/revs/heads/ncq ']'
> + i=2
> + '[' 0 '!=' 0 ']'
> + '[' -z d032ec9048ff82a704b96b93cfd6f2e8e3a06b19 ']'
> + '[' 1 ']'
> + git-read-tree --reset d032ec9048ff82a704b96b93cfd6f2e8e3a06b19
> + git-checkout-cache -q -f -u -a
> + '[' 0 -eq 0 ']'
> + '[' '' ']'
> + rm -f .git/MERGE_HEAD

Regards,

	Jeff


