Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVBAKqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVBAKqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 05:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVBAKqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 05:46:46 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:63656 "EHLO
	webhosting.rdsbv.ro") by vger.kernel.org with ESMTP id S261977AbVBAKqk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 05:46:40 -0500
Date: Tue, 1 Feb 2005 12:46:38 +0200 (EET)
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
X-X-Sender: util@webhosting.rdsbv.ro
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Strange vmstat output. 2.6.10 Scheduler?
In-Reply-To: <20050201104214.GK4137@suse.de>
Message-ID: <Pine.LNX.4.62.0502011243270.26221@webhosting.rdsbv.ro>
References: <Pine.LNX.4.62.0502011217320.26221@webhosting.rdsbv.ro>
 <20050201102638.GJ4137@suse.de> <Pine.LNX.4.62.0502011236100.26221@webhosting.rdsbv.ro>
 <20050201104214.GK4137@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well then that is why, the writes are taking quite a while to reach the
> platter. Nothing is wrong, the drive is just slow :-)
>
> -- 
> Jens Axboe

I don't know what to say because sometimes works really good.
bi=20000.

I'm fighting with this problem for 1 month now and I realy tried to 
resolve the problem.

Postgresql is 8.0.0.

iostat -x 1 shows:
                              extended device statistics
device mgr/s mgw/s    r/s    w/s    kr/s    kw/s   size queue   wait svc_t %b
hda        1    98  190.5   37.1  1161.4   542.5    7.5   2.3   20.4   3.6 81
                              extended device statistics
device mgr/s mgw/s    r/s    w/s    kr/s    kw/s   size queue   wait svc_t %b
hda        0   144    8.3  121.3     0.0  1081.5    8.3   0.0    0.0   7.8 100
                              extended device statistics
device mgr/s mgw/s    r/s    w/s    kr/s    kw/s   size queue   wait svc_t %b
hda        0   134    0.0  122.0     0.0  1016.0    8.3   0.0    0.0   8.2 100
                              extended device statistics
device mgr/s mgw/s    r/s    w/s    kr/s    kw/s   size queue   wait svc_t %b
hda        0   139    0.0  128.3     0.0  1074.7    8.4   0.0    0.0   7.9 100
                              extended device statistics
device mgr/s mgw/s    r/s    w/s    kr/s    kw/s   size queue   wait svc_t %b
hda        0   140    0.0  128.0     0.0  1072.0    8.4   0.0    0.0   7.8 100
                              extended device statistics
device mgr/s mgw/s    r/s    w/s    kr/s    kw/s   size queue   wait svc_t %b
hda        0   121    0.0  115.0     0.0   936.0    8.1   0.0    0.0   8.7 100
                              extended device statistics
device mgr/s mgw/s    r/s    w/s    kr/s    kw/s   size queue   wait svc_t %b
hda        0   140    0.0  123.0     0.0  1072.0    8.7   0.0    0.0   8.1 100
                              extended device statistics
device mgr/s mgw/s    r/s    w/s    kr/s    kw/s   size queue   wait svc_t %b
hda        0   142    0.0  129.0     0.0  1080.0    8.4   0.0    0.0   7.8 100
                              extended device statistics
device mgr/s mgw/s    r/s    w/s    kr/s    kw/s   size queue   wait svc_t %b
hda        0   141    0.0  129.3     0.0  1082.8    8.4   0.0    0.0   7.8 100

Thanks!

P.S. I tried also with cfq and see no improvement.

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
