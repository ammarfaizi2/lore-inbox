Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSFYKYo>; Tue, 25 Jun 2002 06:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSFYKYn>; Tue, 25 Jun 2002 06:24:43 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:12211 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S314448AbSFYKYn>; Tue, 25 Jun 2002 06:24:43 -0400
Date: Tue, 25 Jun 2002 06:26:09 -0400
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NEW PATCH, testers needed] was Re: [PATCH] poll/select fast path
Message-ID: <20020625102609.GA12253@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch should apply & works for me on 2.4 too, no need to use 2.5
> (select/poll are virtually unchanged between 2.4 and 2.5)

Running lmbench on quad xeon with Andi's patch shows a reduction
in select latency in all cases compared to -pre10.

File select - times in microseconds - smaller is better
Average of 25 runs.  -ak-axboe is select/poll patch +
blockhighmem.

                      select select select select  select select select select
kernel                10 fd  100 fd 250 fd 500 fd  10 TCP 100TCP 250TCP 500TCP
--------------------- ------ ------ ------ ------  ------ ------ ------ ------
2.4.19-pre10            4.73  30.66  74.62 143.77    5.67 40.879 97.914 193.10
2.4.19-pre10-ak-axboe   3.85  27.83  71.55 142.78    4.86 37.517 94.205 191.54
2.4.19-pre10-aa4        4.54  29.48  73.96 147.52    5.60 39.485 98.895 194.58
2.4.19-pre10-ac2        4.63  29.60  73.33 141.86    5.64 39.328 98.898 192.82

-- 
Randy Hron
http://home.earthlink.net/~rwhron/bigbox.html

