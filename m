Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131020AbRC0JNV>; Tue, 27 Mar 2001 04:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbRC0JNM>; Tue, 27 Mar 2001 04:13:12 -0500
Received: from hypnos.cps.intel.com ([192.198.165.17]:17107 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S131020AbRC0JND>; Tue, 27 Mar 2001 04:13:03 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B2719D@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Thomas Foerster'" <puckwork@madz.net>, linux-kernel@vger.kernel.org
Subject: RE: URGENT : System hands on "Freeing unused kernel memory: "
Date: Tue, 27 Mar 2001 01:12:02 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it hang forever ?

I've noticed that my kernel (2.4.2) stalls for several minutes with the same
message but suddenly after that the login prompt appears (anything between,
like configurations and services starting messages, are gone). We've been
able to track it down to a change we did to /etc/lilo.conf to add support
for kernel prints to go out to a serial debugger. Before that everything was
OK, but after we added append="console=tty0 console=ttyS1,38400", this
problem started. We did notice however that everything that doesn't appear
on the console does appear on the serial debugger.


	Shmulik.

-----Original Message-----
From: Thomas Foerster [mailto:puckwork@madz.net]
Sent: Tuesday, March 27, 2001 10:40 AM
To: linux-kernel@vger.kernel.org
Subject: Re: URGENT : System hands on "Freeing unused kernel memory: "



> On 03.27 Thomas Foerster wrote:
>>
>> But suddenly the box was offline. One technical assistant from our ISP
tried
>> to reboot
>> our server (he couldn't tell me if there had been any messages on the
screen),
>> but the
>> system always hangs on
>>
>> Freeing unused kernel memory: xxk freed
>>

> Try booting with init=/bin/bash, it looks like kernel gets a bad
/sbin/init,
> and gets stuck. Perhaps the shutdown damaged init, it starts to run and
get
> hung.

That didn't fix the problem :(

When i run "diff" on a new and the "old" init, i get no diffs ...

Must be something other :(

Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

