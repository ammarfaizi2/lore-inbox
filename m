Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262976AbTCSLTn>; Wed, 19 Mar 2003 06:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262978AbTCSLTm>; Wed, 19 Mar 2003 06:19:42 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:14236 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262976AbTCSLTl>; Wed, 19 Mar 2003 06:19:41 -0500
Message-ID: <20030319113033.19451.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: jeremy@goop.org, akpm@digeo.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, efault@gmx.de
Date: Wed, 19 Mar 2003 12:30:33 +0100
Subject: Re: [patch] sched-2.5.64-D3, more interactivity changes
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Jeremy Fitzhardinge <jeremy@goop.org> 
Date: 	18 Mar 2003 23:13:01 -0800 
To: Andrew Morton <akpm@digeo.com> 
Subject: Re: [patch] sched-2.5.64-D3, more interactivity changes 
 
> I'm still getting starvation problems.  If I run xmms with the "Goom" 
> visualizer (with the window large enough that it is CPU-bound), then 
> type a command into a shell window (say, ps), it will not run the 
> command until I close or shrink the goom window.  xmms itself plays 
> fine, though sometimes it fails to go to the next track, apparently for 
> the same reason (ie, it starts the next track when I disable the 
> visualizer). 
 
Well, I'm also experiencing starvation problems with CPU-bound 
loads. For example, I'm converting all my music collection from 
MP3 to OGG, and when using "oggenc" to convert from WAV to 
OGG, the system becomes pretty unresponsive: running commands 
on a terminal (for example a "ps axf") takes forever, unless you 
stop (Ctrl+S) the "oggenc" process. 
 
To avoid this, I had to lower "oggenc" priority using renice. Using 
renice <PID> +20 helped with starvation :-) 
 
Thanks! 
 
   Felipe 
  
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
