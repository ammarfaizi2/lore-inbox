Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVBQBZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVBQBZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 20:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVBQBZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 20:25:24 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:33441 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262189AbVBQBZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 20:25:18 -0500
Date: Thu, 17 Feb 2005 02:25:11 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call for help: list of machines with working S3
Message-ID: <20050217012511.GA11702@mail.muni.cz>
References: <20050216124336.GA27874@mail.muni.cz> <20050216232257.GC3865@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050216232257.GC3865@elf.ucw.cz>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 12:22:57AM +0100, Pavel Machek wrote:
> > does anyone have some experiences with intel i855 video card and S3?
> > 
> > For me the binary driver from Intel works with S3 but only X server is restored
> > not the text console. 
> > 
> > With open source driver nothing is restored. I try to use s3_bios or s3_mode,
> > nothing helps. Using  vbetool and post causes backlight turn on but display is
> > full of garbage (vertical lines of different colors).
> 
> Can you do vga=normal and attempt to reload fonts?

Did not help. Instead, this seems to be working with X.org and opensource driver:

chvt 1
vbetool vbestate save > /tmp/state
echo 3 > /proc/acpi/sleep
vbetool post
vbetool vbestate restore < /tmp/state
chvt 7

(if X server is running then chvt to text console is necessary, but it works
including DRI and XV overlay running) 

Can I get the current console so that chvt 7 can switch to the original console?


Just re-POST seems to initialize first head connected to external CRT. The
second head (connected to LFP) is not initialized. Do not know why :(

This is the videocard: Intel Corp. 82852/855GM Integrated Graphics Device.
Notebook: Acer TM 242FX

-- 
Luká¹ Hejtmánek
