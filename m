Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUAJUfU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbUAJUfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:35:19 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:33178 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S265390AbUAJUfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:35:10 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: Martin Schlemmer <azarah@nosferatu.za.org>,
       "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: Q re /proc/bus/i2c
Date: Sat, 10 Jan 2004 15:35:08 -0500
User-Agent: KMail/1.5.1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401100117.42252.gene.heskett@verizon.net> <3FFFE8E4.8080004@clanhk.org> <1073760037.9096.16.camel@nosferatu.lan>
In-Reply-To: <1073760037.9096.16.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101535.08524.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.61.108] at Sat, 10 Jan 2004 14:35:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 13:40, Martin Schlemmer wrote:
>On Sat, 2004-01-10 at 13:58, J. Ryan Earl wrote:
>> Gene Heskett wrote:
>> >On Friday 09 January 2004 20:47, J. Ryan Earl wrote:
>> >
>> >
>> >I've also got a bttv card, whose init seems to be done quite
>> > early in the bootup, and that requires I have i2c-dev in the
>> > kernel.  So I might as well put it all in, the current
>> > situation.  All in, or all out, it doesn't work.  A run of
>> > sensors right now, returns this:
>>
>> A couple questions:
>>
>> 1) Have you installed the lm-sensors package?
>> 2) What kernel version?
>>
>> Even with 2.6, you need to install the lm-sensors package, but not
>> the i2c package as the kernel already has everything needed in it.
>>  The lm-sensors packages contains drivers for all the sensor
>> chips.  After you get lm-sensors installed on your current kernel,
>> run sensors-detect to get the proper modules loaded for your
>> hardware.
>
>Uhm, AFIAK, you should _NOT_ install the drivers from the lm-sensors
>package, but use those in the kernel.  Check the docs, they
> explicitly say that you should only do:
>
>  # make user user_install

I did this originally, but it did not in fact user_install any new 
code!  I had to install the executables with mc, over-writing the 
sensors, sensors-detect and such files.  And, interesting is that 
while sensors-detect reports that its generated an .init file to be 
copied to /etc/rc.d/init.d/lm_sensors, it has never touched the 
lm_sensors.init file that comes out of the archive.  IMO, something 
is totally fubar (and I've nuked the srcdir and unpacked that 
lm_sensors-2.8.2 archive and re-run this several times now)

>if you have 2.6 kernel.  Further, you do not _need_ lm-sensors
> package, as if you only want to check/monitor one setting, you can
> get it from /sys, and if you use gkrellm, it do not even use
> libsensors anymore (and thus works without, as it have since 2.6
> support, before even libsensors was ported to understand sysfs) ...

gkrellm-2.1.24 is running right now, and the builtins/sensors/info tab 
reports "No sensors detected." at the top of the window.  Everything 
else, including the ups watcher is running just fine.  Is there some 
way I can get some debugging info out of gkrellm when started from a 
cli?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

