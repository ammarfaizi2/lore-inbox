Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVLNLcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVLNLcL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVLNLcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:32:11 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:39871 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S932428AbVLNLcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:32:10 -0500
Subject: Re: bugs?
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: sander@humilis.net
Cc: Willy Tarreau <willy@w.ods.org>,
       Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>,
       linux-kernel@vger.kernel.org, coywolf@gmail.com
In-Reply-To: <20051214105723.GA25166@favonius>
References: <439F79CE.6040609@ens.etsmtl.ca>
	 <20051214024316.GG15993@alpha.home.local> <20051214105723.GA25166@favonius>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 14 Dec 2005 12:32:27 +0100
Message-Id: <1134559947.8885.8.camel@noti>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo!

You could try:
  
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 

It's possible that you have chosen "power_save".
You can see possible settings in 

sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors

Try "performance"!
Then you should get your 1,4 GHz.
But be aware, that this is not powersaving!
Maybe you can play around with it.
A good possibility is to install an userspace application for governing
the cpu-speed lik cpufreqd



Dirk


Am Mittwoch, den 14.12.2005, 11:57 +0100 schrieb Sander:
> Willy Tarreau wrote (ao):
> > On Tue, Dec 13, 2005 at 08:47:58PM -0500, Caroline GAUDREAU wrote:
> > > my cpu is 1400MHz, but why there's cpu MHz         : 598.593
> > > 
> > > caro@olymphe:~$ cat /proc/cpuinfo
> > > processor       : 0
> > > vendor_id       : GenuineIntel
> > > cpu family      : 6
> > > model           : 9
> > > model name      : Intel(R) Pentium(R) M processor 1400MHz
> > > stepping        : 5
> > > cpu MHz         : 598.593
> > > cache size      : 1024 KB
> > 
> > It's probably a notebook that you started unplugged from the mains
> > power. Mine is stupid enough to believe that I *want* to save power if
> > I plug the mains *after* powering it up ! And there's no way to force
> > it to switch from 600 to nominal freq afterwards ! So I have to
> > connect it to the mains first.
> 
> If you say this based on 'cat /proc/cpuinfo' output: isn't it true that
> /proc/cpuinfo is static, and doesn't necessarily reflect the actual
> speed of the processor?
> 
-- 
Dirk Henning Gerdes
Bönnersdyk 47
47803 Krefeld

Tel:  02151-755745
      0174-7776640
Mail: mail@dirk-gerdes.de

