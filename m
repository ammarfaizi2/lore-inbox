Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265507AbUAJXhj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 18:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbUAJXhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 18:37:39 -0500
Received: from ns.clanhk.org ([69.93.101.154]:11143 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S265507AbUAJXhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 18:37:36 -0500
Message-ID: <40003718.2010007@clanhk.org>
Date: Sat, 10 Jan 2004 17:32:08 +0000
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: gene.heskett@verizon.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Q re /proc/bus/i2c
References: <200401100117.42252.gene.heskett@verizon.net>	 <3FFF59A0.2080503@clanhk.org> <200401100754.47752.gene.heskett@verizon.net>	 <3FFFE8E4.8080004@clanhk.org> <1073760037.9096.16.camel@nosferatu.lan>
In-Reply-To: <1073760037.9096.16.camel@nosferatu.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:

>On Sat, 2004-01-10 at 13:58, J. Ryan Earl wrote:
>  
>
>>>A couple questions:
>>>
>>>1) Have you installed the lm-sensors package?
>>>2) What kernel version?
>>>
>>>Even with 2.6, you need to install the lm-sensors package, but not the 
>>>i2c package as the kernel already has everything needed in it.  The 
>>>lm-sensors packages contains drivers for all the sensor chips.  After 
>>>you get lm-sensors installed on your current kernel, run sensors-detect 
>>>to get the proper modules loaded for your hardware.
>>>
>>>      
>>>
>
>Uhm, AFIAK, you should _NOT_ install the drivers from the lm-sensors
>package, but use those in the kernel.  Check the docs, they explicitly
>say that you should only do:
>
>  # make user user_install
>
>if you have 2.6 kernel.  Further, you do not _need_ lm-sensors package,
>as if you only want to check/monitor one setting, you can get it from
>/sys, and if you use gkrellm, it do not even use libsensors anymore
>(and thus works without, as it have since 2.6 support, before even
>libsensors was ported to understand sysfs) ...
>  
>
It still uses devfs I think.  Or you can just run the mkdev.sh command 
to create the proper devices.

This is from installing lm-sensors:

 * *****************************************************************
 *
 * This ebuild assumes your /usr/src/linux kernel is the one you
 * used to build i2c-2.8.2.
 *
 * For 2.5+ series kernels, use the support already in the kernel
 * under 'Character devices' -> 'I2C support' and then merge this
 * ebuild.
 *
 * To cross-compile, 'export LINUX="/lib/modules/<version>/build"'
 * or symlink /usr/src/linux to another kernel.
 *
 * *****************************************************************

You always need the lm-sensors package, period--it has all the user land 
utilities plus drivers for most of the chips/sensors.  You only need the 
i2c package on earlier kernels, use built in for 2.6.  On my Asus 
boards, I use the asb100 module which is not in the kernel.  `find 
/usr/src/linux -name asb100* -print`  Not there.  Remember, you'll have 
to recompile the lm-sensors package everytime you upgrade you change 
your kernel.

-ryan

