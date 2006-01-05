Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWAEMoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWAEMoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWAEMoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:44:38 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:47546 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S1751317AbWAEMoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:44:37 -0500
In-Reply-To: <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr>
References: <20050726150837.GT3160@stusta.de> <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> <20060103215654.GH3831@stusta.de> <9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com> <s5hpsn8md1j.wl%tiwai@suse.de> <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr> <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de> <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de>
Cc: Takashi Iwai <tiwai@suse.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Thu, 5 Jan 2006 13:44:14 +0100
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-05, at 11:57, Jan Engelhardt wrote:

>>> Software mixing in the kernel is like FPU ops in the kernel...
>>
>> Could you please elaborate a tad bit more on the analogy? It  
>> doesn't appear to
>> be stunningly obvious.
>>
> It has never been done before in Linux, so there must be a reason  
> to it.
> There was also a reason why khttpd was (going in and) going out.
>
>> Are you aware of the reasons why floating point operations are  
>> avoided inside
>> the kernel?
>>
> Because it is "unportable". You cannot expect to have every  
> hardware Linux
> runs on today to have an FPU engine (hey, like that ol' i386 I got,  
> needs
> CONFIG_MATH_EMU...), especially in the Embedded Devices sector.

First - the answer you provide is far from complete and it doesn't  
even touch the more important reasons why the kernel avoids doing  
FPU. (No, I don't feel obliged to explain the issue to you. Just a  
note: The reasons are just merely *technical* and not principal.)

Second - you still didn't explain why this allows you to conclude  
that sound mixing should in no way be done inside the kernel.
