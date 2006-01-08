Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWAHTUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWAHTUr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWAHTUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:20:47 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:64926 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1161101AbWAHTUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:20:46 -0500
From: Grant Coady <gcoady@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Date: Mon, 09 Jan 2006 06:20:41 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <aap2s1diakl9dg7noa8a4p4kr688lhc1b5@4ax.com>
References: <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com> <E1EvUp6-0008Ni-00@calista.inka.de> <irf1s1hdoqbsf9cin627gh9tgrsb51htoe@4ax.com> <Pine.LNX.4.61.0601081303140.30148@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601081303140.30148@yvahk01.tjqt.qr>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 13:04:22 +0100 (MET), Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

>
>>grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96
>>
>>real    0m1.671s
>>user    0m0.550s
>>sys     0m0.300s
>>grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96 >/dev/null
>>
>>real    0m0.510s
>>user    0m0.420s
>>sys     0m0.080s
>
>Given that the first command is the first one accessing access_log at 
>all, then: the second time, access_log is already cached and 
>therefore can be accessed faster.

I did repeat measurements to check for variation due to caching, 
and that is not what is happening, we comparing going out over 
ssh terminal to dumping output locally.

Grant.
