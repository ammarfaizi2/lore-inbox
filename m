Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287874AbSAMBwn>; Sat, 12 Jan 2002 20:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287936AbSAMBwd>; Sat, 12 Jan 2002 20:52:33 -0500
Received: from jalon.able.es ([212.97.163.2]:59646 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S287933AbSAMBwY>;
	Sat, 12 Jan 2002 20:52:24 -0500
Date: Sun, 13 Jan 2002 02:57:28 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, Andrea Arcangeli <andrea@suse.de>,
        yodaiken@fsmlabs.com, jogi@planetzork.ping.de,
        Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020113025728.A1569@werewolf.able.es>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3C409B2D.DB95D659@zip.com.au>; from akpm@zip.com.au on Sat, Jan 12, 2002 at 21:23:09 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020112 Andrew Morton wrote:
>Ed Sweetman wrote:
>> 
>> If you want to test the preempt kernel you're going to need something that
>> can find the mean latancy or "time to action" for a particular program or
>> all programs being run at the time and then run multiple programs that you
>> would find on various peoples' systems.   That is the "feel" people talk
>> about when they praise the preempt patch.
>
>Right.  And that is precisely why I created the "mini-ll" patch.  To
>give the improved "feel" in a way which is acceptable for merging into
>the 2.4 kernel.
>
>And guess what?   Nobody has tested the damn thing, so it's going
>nowhere.
>

I have been running mini-ll on -pre3 for a time. And have just booted pre3
with full-ll. I see no marvelous diff between them, but I am not pushing
my box to their knees. 
I can get numbers for you, but is there any test out there that gives them ?
Something like 'under this damned test your system just delayed as much as xxx us'.
That kind of 'my xmms does not skip' does not look like a very serious measure.

And could you tell me if some of this patches can interfere with results ?
This is what I am running just now:
- 2.4.18-pre3
- vm fixes from aa (vm-22, vm-raend, truncate-garbage)
- ext3-0.9.17 update
- ide-20011210 (hint: plz, make it in mainline for the time of .18...)
- irqrate-A1
- interrupts-seq-file
- spinlock-cacheline + fast-pte from -aa
- scalable timers
- sensors-cvs
- bproc 3.1.5

On that i have run full-ll+ll_fixes (from -aa) or mini-ll+ll_fixes.

(If someone is interested, patches are at
http://giga.cps.unizar.es/~magallon/linux/ )

TIA.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre3-beo #5 SMP Sun Jan 13 02:14:04 CET 2002 i686
