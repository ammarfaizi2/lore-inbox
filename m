Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUDIGry (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 02:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUDIGrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 02:47:53 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:40975 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261875AbUDIGrw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 02:47:52 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: cat /dev/hdb > /dev/null DoS
Date: Fri, 9 Apr 2004 09:47:38 +0300
X-Mailer: KMail [version 1.4]
References: <20040408085518.B4607@beton.cybernet.src> <c539ur$h5e$1@sea.gmane.org> <c54pi2$u9b$1@sea.gmane.org>
In-Reply-To: <c54pi2$u9b$1@sea.gmane.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200404090947.39069.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 April 2004 03:10, Sven Köhler wrote:
> > i guess you have DMA enabled on /dev/hdb. I would expect, that the
> > system is at least 50% idle
>
> i did
>    dd if=/dev/hda of=/dev/null bs=1M
> and noticed, that top shows 0% idle, but 95% wa - what ever that means.
>
> Since i've got DMA turned on, i would expect the CPU to be 95% idle,
> instead 95% wa? what does "wa" stand for?

top version? Mine is 2.0.18, looks like this:

 09:47:25  up 1 day, 17:07,  2 users,  load average: 0.42, 0.27, 0.24
116 processes: 114 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:   4.2% user  52.1% system   0.0% nice  43.6% iowait   0.0% idle
Mem:   122736k av,  121088k used,    1648k free,       0k shrd,   22968k buff
        76324k active,              21000k inactive
Swap:   76792k av,   67004k used,    9788k free                   25748k cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
15022 root      18   0  2280 1460  1200 R    38.6  1.1   0:05   0 dd
-- 
vda
