Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318304AbSIFFka>; Fri, 6 Sep 2002 01:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318344AbSIFFka>; Fri, 6 Sep 2002 01:40:30 -0400
Received: from webmail22.rediffmail.com ([203.199.83.144]:29625 "HELO
	webmail22.rediffmail.com") by vger.kernel.org with SMTP
	id <S318304AbSIFFk3>; Fri, 6 Sep 2002 01:40:29 -0400
Date: 6 Sep 2002 05:37:18 -0000
Message-ID: <20020906053718.32530.qmail@webmail22.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Illegal Instruction
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

My kernel is crashing when i try to insmod a driver. I am getting 
the following error messages


insmod:19] Illegal instruction 000003e8 at c0015cf4 ra=c0088dd4
[[insmod:19] Illegal instruction c000d9d4 at c000b6a4 
ra=c000b69c

When i tried to locate this happens when i call rt_usleep 
function.
This is the piece of code where i call nano2count.

void mysleep (uint32 micro_sec)
{
    RTIME delay;

    delay = nano2count (micro_sec * 1000LL);
    rt_sleep (delay);
}

I am exactly getting the insmod error when there is a call to 
nano2count.
Note : RTIME is of type "long long".
The CPU i am using is IDT RC32334.

Can any body help me to solve this?

with best regards,
Nanda
