Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTJVWRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 18:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTJVWRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 18:17:12 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:57762 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261262AbTJVWRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 18:17:10 -0400
Message-ID: <3F970199.2050404@comcast.net>
Date: Wed, 22 Oct 2003 15:15:53 -0700
From: C S Rosenmund <gnuman@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8 backlight and sound problems (PMU) on PPC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware is an early iBook (first gen - Clamshell)

with 2.6.0-test8, sound does not recover from sleep when an application 
is using it when the notebook is slept (can be reproduced: using pysol, 
with sound enabled, close the lid to sleep the laptop, then anytime 
after the sound stops (indicating that the laptop is sleeping) open the 
lid. Sound does not return, and the application does not close) The 
symptoms (indicated above) seem to point to the sound module (also when 
compiled into the kernel) hanging up on sleep. Sound hardware is 
pmac-dmasound.

two problems on the backlight (probably related):
the backlight control buttons do not work (the brightness of the 
backlight does not change) and when the laptop goes to sleep, the 
backlight does not turn off (it does turn off for console blanking as in 
when the unit is left idle for some time, and the screen goes blank).

I was unable to find any reference to this in the archives, so I'm not 
sure if this has been noticed yet.

Results of ver_linux:
Linux Blueberry 2.6.0-test8 #10 Tue Oct 21 22:02:41 PDT 2003 ppc GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre2
e2fsprogs              1.35-WIP
PPP                    2.4.2b3
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         dmasound_pmac dmasound_core soundcore
Blueberry:/usr/src/linux-2.6.0-test8/scripts#

do you need more info than this? If so, what?

Sanjay
gnuman@comcast.net

