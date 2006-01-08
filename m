Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752590AbWAHMEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbWAHMEa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 07:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbWAHMEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 07:04:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26061 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752590AbWAHME3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 07:04:29 -0500
Date: Sun, 8 Jan 2006 13:04:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Grant Coady <gcoady@gmail.com>
cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
In-Reply-To: <irf1s1hdoqbsf9cin627gh9tgrsb51htoe@4ax.com>
Message-ID: <Pine.LNX.4.61.0601081303140.30148@yvahk01.tjqt.qr>
References: <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com>
 <E1EvUp6-0008Ni-00@calista.inka.de> <irf1s1hdoqbsf9cin627gh9tgrsb51htoe@4ax.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96
>
>real    0m1.671s
>user    0m0.550s
>sys     0m0.300s
>grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96 >/dev/null
>
>real    0m0.510s
>user    0m0.420s
>sys     0m0.080s

Given that the first command is the first one accessing access_log at 
all, then: the second time, access_log is already cached and 
therefore can be accessed faster.


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
