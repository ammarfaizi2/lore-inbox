Return-Path: <linux-kernel-owner+w=401wt.eu-S932704AbWLaDaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWLaDaw (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 22:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWLaDaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 22:30:52 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:64068 "EHLO
	mtiwmhc13.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932704AbWLaDav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 22:30:51 -0500
Message-ID: <45972EFD.3010103@lwfinger.net>
Date: Sat, 30 Dec 2006 21:31:09 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Regression in 2.6.19 and 2.6.20 for snd_hda_intel
References: <45971053.7040609@lwfinger.net> <45971F39.4060301@gentoo.org>
In-Reply-To: <45971F39.4060301@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Larry Finger wrote:
>> When this commit is reverted, I get sound, but playing a sound file
>> results in about an 0.5 sec
>> fragment being replayed over and over forever. If commit
>> 7376d013fc6d3a45..., which is entitled
>> "Simple patch to enable Message Signalled Interrupts for the HDA Intel
>> audio controller" is
>> reverted, the sound works fine.
> 
> MSI is now disabled by default on this driver, so I'm pretty sure you
> only have the first bug talking in terms of the most recent kernels.

You are correct. Only the "hda_codec-Add independent headphone volume control" needs to be reverted.

Thanks,

Larry
