Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVEQUXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVEQUXg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVEQUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:23:36 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:15816 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261861AbVEQUXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:23:30 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Date: Wed, 18 May 2005 06:23:28 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <0pik81hjboqvbf2jhgdut861cfpgl7sata@4ax.com>
References: <2538186705051703479bd0c29@mail.gmail.com> <e9iUj0EZ.1116327879.1515720.khali@localhost> <2538186705051704181a70dbbf@mail.gmail.com>
In-Reply-To: <2538186705051704181a70dbbf@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yani,
On Tue, 17 May 2005 07:18:51 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:

Following is derived from gcc -E adm1026.c with your patch (the 
script strips all but base number from numbered names):

adm1026.c    SENSOR_fan1_div                    RW
adm1026.c    SENSOR_fan1_input                  R
adm1026.c    SENSOR_fan1_min                    RW
adm1026.c    SENSOR_in0_input                   R
adm1026.c    SENSOR_in0_max                     RW
adm1026.c    SENSOR_in0_min                     RW
adm1026.c    SENSOR_temp1_auto_point1_temp      RW
adm1026.c    SENSOR_temp1_auto_point1_temp_hyst R
adm1026.c    SENSOR_temp1_crit                  RW
adm1026.c    SENSOR_temp1_input                 R
adm1026.c    SENSOR_temp1_max                   RW
adm1026.c    SENSOR_temp1_min                   RW
adm1026.c    SENSOR_temp1_offset                RW
adm1026.c    alarm_mask                         RW
adm1026.c    alarms                             R
adm1026.c    analog_out                         RW
adm1026.c    gpio                               RW
adm1026.c    gpio_mask                          RW
adm1026.c    pwm1                               RW << these also should also
adm1026.c    pwm1_enable                        RW << have SENSOR_ in front 
adm1026.c    temp1_auto_point1_pwm              RW << of them, seems you 
adm1026.c    temp1_crit_enable                  RW << missed a group?
adm1026.c    vid                                R
adm1026.c    vrm                                RW

I'm assuming some magic elsewhere sees that 'SENSOR_' and removes 
it before it gets to sysfs.  I can test adm9240, w83627hf and it87 
drivers as well as watch the overall patterns as above.

--Grant.

