Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUEOQgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUEOQgj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 12:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUEOQgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 12:36:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:28125 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264685AbUEOQgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 12:36:37 -0400
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6: ALSA sound/ppc/keywest.c:84: tumbler: cannot initialize
 the MCS
References: <m3y8nzgbmo.fsf@whitebox.m5r.de> <s5hu0yndose.wl@alsa2.suse.de>
	<jelljxpgjs.fsf@sykes.suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: YOW!!  Everybody out of the GENETIC POOL!
Date: Sat, 15 May 2004 18:36:35 +0200
In-Reply-To: <jelljxpgjs.fsf@sykes.suse.de> (Andreas Schwab's message of
 "Wed, 12 May 2004 21:54:31 +0200")
Message-ID: <jesme1y7e4.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> Takashi Iwai <tiwai@suse.de> writes:
>
>> At Tue, 11 May 2004 00:28:47 +0200,
>> Andreas Schwab wrote:
>>> 
>>> I've never been able to get a working sound with ALSA after booting my
>>> iBook G3 (dmasound is working fine).  Any idea what's wrong with
>>> snd-powermac?
>>
>> does the attached patch work?  it's a partial patch from the latest
>> ALSA cvs tree.
>> the problem seems like the initialization of i2c-keywest.
>
> I have now imported the alsa patch from 2.6.6-mm1 and the problem seems
> to be fixed.

Actually there are still similar problems when waking up:

kernel: tumbler_init_client error
kernel: ALSA sound/ppc/tumbler.c:589: failed to set mono volume 7
last message repeated 2 times
kernel: ALSA sound/ppc/tumbler.c:460: failed to set mono volume 1
kernel: ALSA sound/ppc/tumbler.c:460: failed to set mono volume 2
kernel: ALSA sound/ppc/tumbler.c:356: failed to set DRC
kernel: ALSA sound/ppc/tumbler.c:221: failed to set volume 

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
