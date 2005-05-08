Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVEHAIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVEHAIJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 20:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVEHAIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 20:08:09 -0400
Received: from smtp05.auna.com ([62.81.186.15]:48125 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S262763AbVEHAID convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 20:08:03 -0400
Date: Sun, 08 May 2005 00:07:49 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
To: linux-kernel@vger.kernel.org
References: <20050504221057.1e02a402.akpm@osdl.org>
In-Reply-To: <20050504221057.1e02a402.akpm@osdl.org> (from akpm@osdl.org on
	Thu May  5 07:10:57 2005)
X-Mailer: Balsa 2.3.1
Message-Id: <1115510869l.7472l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.05, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> 
> - device mapper updates
> 
> - more UML updates
> 
> - -mm seems unusually stable at present.
> 

Ehem, is ALSA broken ?

I can't spread stereo output to 4 channel. More specific, I can't switch
one of my female jacks between in and out.

Long explanation: I have an

00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)

It has three outputs. One is always output, for normal stereo or front in 4
channel. One other is LineIn/Back-for-4-channel. And the third is
Mic/Bass-Center.

In 2.6.11 I have two
toggles in ALSA: 'Spread front to center...' and 'surround jack as input'
Adjusting both I could get to duplicate the output in the Back jack.
In 2.6.12-rc3-mm3 there is no way to get this working.

More, after I booted 2.6.11 to retest, just after reboot in 2.6.12-rc3-mm3
it was working. As soon as I touched the 'Surround Jack Mode' in alsamixer
it went silent again, and I could not restore it.
The old options have been renamed/killed.

Is ALSA broken in kernel ? Is just the userspace out of sync ?
Which should be the correct setup to get this working ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam16 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


