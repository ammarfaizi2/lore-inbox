Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSKRF21>; Mon, 18 Nov 2002 00:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSKRF21>; Mon, 18 Nov 2002 00:28:27 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:32529 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261463AbSKRF21>;
	Mon, 18 Nov 2002 00:28:27 -0500
Date: Mon, 18 Nov 2002 00:34:32 -0500 (EST)
Message-Id: <200211180534.gAI5YWw237230@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org, Mario.Holbe@RZ.TU-limenau.DE,
       alan@lxorguk.ukuu.org.uk, tim@physik3.uni-rostock.de
Subject: Re: /proc/stat interface and 32bit jiffies / kernel_stat
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "ps" will report processes started before the jiffies wrap
> as being started in the future, but this won't do any harm.

Sure it does harm. You might kill the wrong process,
like so:

pgrep -n foo      # kill the newest foo

The CPU usage stats in "top" will also be horribly messed up.
