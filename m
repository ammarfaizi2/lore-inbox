Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTCOOeh>; Sat, 15 Mar 2003 09:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbTCOOeh>; Sat, 15 Mar 2003 09:34:37 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:5265 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261456AbTCOOeg>; Sat, 15 Mar 2003 09:34:36 -0500
Subject: Re: 2.5.64-mm7
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1047739525.2275.16.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Mar 2003 09:45:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[..SNIP..]

> 
> > . Niggling bugs in the anticipatory scheduler are causing problems.
I've 
> > reset the default to elevator=deadline until we get these fixed up. 
> 
> I haven't still experienced those bugs using mm6 and AS. 


	Me either. 


> Is there an easy way to reproduce them? 


	If there was, they'd be fixed.

I get bit by the AS bugs on recent -mm kernels. It is reproducible every
time I start X. Here are a few points to my setup that might help
someone to reproduce the problem.

1. My home dir is on a LVM striped LV across two IDE disks.

2. Recently I had modified my .xinitrc like this:

	# Nice smooth X under load
	#sudo /usr/bin/renice -10 $(pgrep -u root X)

	exec gnome-session

I have confirmed that removing the renice allows X/gnome to progress
further through the startup.

Shane








