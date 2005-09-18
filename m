Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVIRQDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVIRQDA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 12:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVIRQDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 12:03:00 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:22154 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932107AbVIRQC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 12:02:59 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: Eradic disk access during reads
Date: Sun, 18 Sep 2005 19:02:17 +0300
User-Agent: KMail/1.8.2
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <200509170717.03439.a1426z@gawab.com> <200509181400.27004.vda@ilport.com.ua> <200509181640.19984.a1426z@gawab.com>
In-Reply-To: <200509181640.19984.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509181902.17633.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > # dd if=/dev/hda of=/dev/null bs=16M
> > > 2.4.31 # nmeter t6 c x i b d100
> > > 18:56:36.009981 cpu [SSSSSSSS..] ctx  145 int   86 bio 4.7M    0
> > > 18:56:36.110327 cpu [SSSSSSSS..] ctx  145 int   87 bio 4.8M    0
> > > 18:56:36.210735 cpu [SSSSSSSS..] ctx  139 int   88 bio 4.7M    0
> > > 18:56:36.310315 cpu [SSSSSSSS..] ctx  142 int   85 bio 4.7M    0
> > >
> > > 2.6.13 # nmeter t6 c x i b d100
> > > 18:09:22.117959 cpu [SSSSSSSSSD] ctx   80 int   47 bio 4.7M    0
> > > 18:09:22.217932 cpu [SSSSSSDDDD] ctx   83 int   48 bio 4.8M    0
> > > 18:09:22.319200 cpu [SSSSDDDDDI] ctx   81 int   56 bio 4.7M  28k
> > > 18:09:22.407979 cpu [SSSSSSSSSD] ctx   60 int   38 bio 3.8M    0
> > > 18:09:22.517960 cpu [SSSSSSSSDI] ctx   95 int   61 bio 5.2M  52k
> >
> > Well, I do not see any bursts you mention...
> 
> Can you try 2.4.31?

Not easy. I guess I have quite a few 2.6-only things here...

> same here.
> 
> > My CPU is not that new:
> 
> PII - 400Mhz here.

I meant that kernel seem to eat too much CPU here. This
is not expected. I expected CPU bar to be all D.
 
> > hdc (an old disk):
> > 13:52:40.201718 cpu [SSSDDDDDDD] ctx   26 int  112 bio 1.2M    0
> > 13:52:40.301569 cpu [SSDDDDDDDD] ctx   28 int  109 bio 1.2M    0
> > 13:52:40.402552 cpu [SSDDDDDDDI] ctx   23 int  111 bio 1.2M    0
> > 13:52:40.502535 cpu [SSDDDDDDDD] ctx   22 int  110 bio 1.2M    0
> > 13:52:40.601507 cpu [SSDDDDDDDI] ctx   26 int  111 bio 1.2M    0
> > 13:52:40.701493 cpu [SSDDDDDDDD] ctx   23 int  110 bio 1.2M    0
> 
> Looks smooth.
> 
> Also, great meter!  Best of all does not hog the CPU!
> Could you add a top3 procs display?

What is a "top3 procs display"?
--
vda
