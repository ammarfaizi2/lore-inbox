Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSJUVXu>; Mon, 21 Oct 2002 17:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbSJUVXu>; Mon, 21 Oct 2002 17:23:50 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:13586 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id <S261686AbSJUVXt>; Mon, 21 Oct 2002 17:23:49 -0400
Date: Mon, 21 Oct 2002 12:01:04 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Cc: jchua@fedex.com
Subject: Re: 2.5.44 console keyboard dead
Message-ID: <20021021100104.GA349@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't type anything on the console keyboard on 2.5.44
> rlogin works ok.
> Thanks,
> Jeff 

I had this problem as well until I realized that the following options had to be enabled in the config (provided that you have a PS/2 or AT keyboard which I guess you do).

Under input device support
==========================
Select "Serial i/o support"
Select "i8042 PC Keyboard controller"
Select "Keyboards"
Select "AT Keyboard support"

This is indicated in the help text but the current layout is very unintuitive and should be changed.

Explaination:
The first time that I compiled, I simply choose "Keyboards", no extra options appeared since "Serial i/o support" wasn't selected and thus it seemed as if everything was just fine...until I booted and the keyboard didn't work. Then I started reading help messages :-)

Regards,
David
