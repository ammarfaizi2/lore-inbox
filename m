Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbTAXXbi>; Fri, 24 Jan 2003 18:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAXXbi>; Fri, 24 Jan 2003 18:31:38 -0500
Received: from smtp.terra.es ([213.4.129.129]:35680 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id <S265816AbTAXXbh>;
	Fri, 24 Jan 2003 18:31:37 -0500
Date: Sat, 25 Jan 2003 00:41:01 +0100
From: Arador <diegocg@teleline.es>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, jun.nakajima@intel.com,
       asit.k.mallick@intel.com, sunil.saxena@intel.com
Subject: Re: 2.5.59-mm5: cpu1 not working
Message-Id: <20030125004101.5976149a.diegocg@teleline.es>
In-Reply-To: <E88224AA79D2744187E7854CA8D9131DFEE8B7@fmsmsx407.fm.intel.com>
References: <E88224AA79D2744187E7854CA8D9131DFEE8B7@fmsmsx407.fm.intel.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003 14:44:17 -0800
"Kamble, Nitin A" <nitin.a.kamble@intel.com> wrote:

> Hi Arador,
>   There is nothing wrong with the /proc/interrupts output. The kirq patch balances the interrupts load only when there is sizable load imbalance, which you don't seem to have. In such cases interrupts will not move around.
>    Try generating lots of interrupts load in the system, and then the interrupts will get distributed across CPUs.



true, sorry for the noise
After ping -f i got
11:    1446896    1452624   IO-APIC-level  eth0

cat /dev/hda was not enought to "distribute" the interrupts it seems.

btw, ping -f hits 24000-29000 int. per second; adding
a cat /dev/hda slows it down to 20, 22000. Shouldn't
it redistribute the interrupts in a way you get > 29000?
(note that i've not idea of this thing)


Diego Calleja
