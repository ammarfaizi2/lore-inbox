Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVCVD5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVCVD5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVCVDyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:54:55 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:16748 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262247AbVCVDtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:49:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Mon, 21 Mar 2005 22:49:08 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200503201557.58055.pmcfarland@downeast.net> <200503212215.58544.dtor_core@ameritech.net> <200503212241.26780.pmcfarland@downeast.net>
In-Reply-To: <200503212241.26780.pmcfarland@downeast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503212249.09512.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 22:41, Patrick McFarland wrote:
> On Monday 21 March 2005 10:15 pm, Dmitry Torokhov wrote:
> > Looks good, I was wondering if you had GAMEPORT=m and SND_ENS1371=y.
> 
> Yes, that would be quite silly. ;)
> 
> > > For the curious, what was the first kernel to be released that had your
> > > sysfs stuff in it?
> >
> > 2.6.11-mm and 2.6.12-rc1. Vanilla 2.6.11 does not have it.
> 
> I'll go compile 2.6.11 to see if it works there.
> 
> > Could you verify that you enabled joystick port on card? What does
> > "cat /sys/module/snd_ens1371/parameters/joystick_port" show?
> 
> 0,0,0,0,0,0,0,0
> 

Ok, it looks like setup problem. Try doing:

	modprobe snd-ens1371 joystick_port=1

-- 
Dmitry
