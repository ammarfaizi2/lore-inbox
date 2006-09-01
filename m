Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWIAO01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWIAO01 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 10:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWIAO00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 10:26:26 -0400
Received: from main.gmane.org ([80.91.229.2]:16529 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932089AbWIAO00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 10:26:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: RFC - sysctl or module parameters.
Date: Fri, 01 Sep 2006 17:25:36 +0200
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <44F850F0.5050603@flower.upol.cz>
References: <17655.38092.888976.846697@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Neil Brown <neilb@suse.de>
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <17655.38092.888976.846697@cse.unsw.edu.au>
X-Image-Url: http://flower.upol.cz/~olecom/upol-cz.png
X-Face: =sibd$\hCvyTK_%u<|5M05t1lOc1Ld1'SSQ`+=v3P7:)0g%v{U`~4(q4"X(az&asiUNG.C3)XS1E`)4O'hK0{r}P9fxtLGVWvQQJekut9!Q"K8H2l>/Tfd.~R@PoY{TfjXUht[HdA+.Ncy?W;*K$5v(|n-=C6mne&mN}1(n
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> There are so many ways to feed configuration parameters into the
> kernel these days.  
> There is sysctl.  There is sysfs. And there are module paramters.
> (procfs? who said procfs? I certainly didn't).
> 
> I have a module - let's call it 'lockd'.
> I want to make it configurable - say to be able to identify
>  peers by IP address (as it currently does) or host name
>  (good for multi homed peers, if you trust them).
> 
> And I want Jo Sysadmin to be able to set some simple configuration
> setting somewhere and have it 'just work'.
> 
I'm already working on etab (external text and binary) config interface
<http://permalink.gmane.org/gmane.linux.debian.devel.kernel/21781>.

I wish to apply it to firmwares (as for once-loaded, as for multi-loaded). It
can also be used for any type (boot, runtime) of configuration needed for many
kernel parts.
In short: there is a config provider inside kernel -- dictionary, where keys
are names of modules (even in static build), every module knows what it needs,
and thus admin knows how to construct configuration and place in location on
file system, or feed in to etab when needed. Generally, there two userspace
interfaces: bootloader (initrd=) and runtime (chardev /dev/etab). No need in
*fs, modification in module-init-tools, just a dictionary in kernel.

Sorry for my English, and say it's stupid if it is.

Thanks.

-- 
-o--=O`C  /. .\   (+)
  #oo'L O      o    |
<___=E M    ^--    |  (you're barking up the wrong tree)

