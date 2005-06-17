Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVFQKlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVFQKlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 06:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVFQKlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 06:41:13 -0400
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:28548 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261939AbVFQKlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 06:41:07 -0400
Message-ID: <42B2A8BC.4070201@lifl.fr>
Date: Fri, 17 Jun 2005 12:41:00 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Voluspa <lista1@telia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6 missing commit(s) in cpufreq?
References: <20050617122155.0d8190c2.lista1@telia.com>
In-Reply-To: <20050617122155.0d8190c2.lista1@telia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06/17/2005 12:21 PM, Voluspa wrote/a écrit:
> According to:
> http://www.kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.12-rc6
> 
> There should be a:
> 
> commit 1206aaac285904e3e3995eecbf4129b6555a8973
> Author: Dave Jones <davej@redhat.com>
> Date:   Tue May 31 19:03:48 2005 -0700
> 
>     [CPUFREQ] Allow ondemand stepping to be changed by user.
> 
> And when I look at:
> http://www.kernel.org/git/?p=linux/kernel/git/davej/cpufreq.git;a=commit;h=1206aaac285904e3e3995eecbf4129b6555a8973
> 
:
> 
> Problem is that neither a clean 2.6.11 patched with patch-2.6.12-rc6 nor
> a full linux-2.6.12-rc6.tar.bz (I just downloaded it) contain that
> commit.
Yes, it is in linux-2.6.12-rc6, but also "[CPUFREQ] ondemand governor 
automatic downscaling" which back off this change because it introduce a 
new algorithm which compute automatically this step to the best value.

The cpufreq tree was going during three months separatetly and then all 
the commits went inside the Linus's tree at once. It might look strange 
then, but nothing to worry :-)

:
> Even more strange is the other discrepancies in that list, suggesting
> other missed commits. Live directory from 2.6.12-rc :
> 
> root:sleipner:/sys/devices/system/cpu/cpu0/cpufreq/ondemand# ls
> total 0
> 0 ignore_nice           0 sampling_rate      0 sampling_rate_min
> 0 sampling_down_factor  0 sampling_rate_max  0 up_threshold
That's what you should see, everything is ok :-)

> 
> Perhaps this is why I can't get the conservative governor to work at all
> (it just sits at the freq at which it was loaded, never going up/down no
> matter the load).
I think it's completetly unrelated. Probably it's better to discuss 
about this bug on the cpufreq mailing list: cpufreq@lists.linux.org.uk

Eric
