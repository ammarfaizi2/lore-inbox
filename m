Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVCXUjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVCXUjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVCXUji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:39:38 -0500
Received: from ns.suse.de ([195.135.220.2]:13786 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261169AbVCXUiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:38:12 -0500
Message-ID: <4243252D.6090206@suse.de>
Date: Thu, 24 Mar 2005 21:38:05 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org>
In-Reply-To: <20050324181059.GA18490@hexapodia.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
> On Thu, Mar 24, 2005 at 03:27:15PM +0100, Stefan Seyfried wrote:

> Sysrq still prints stuff, so IRQs aren't locked.  But most of the sysrq
> commands don't work... S and U don't seem to do anything (not too
> suprising I suppose) but B does reboot.

sysrq-t will probably show a stuck kseriod. Unfortunately it only
happens on one machine for me (toshiba P10-550 IIRC, P4HT but with
non-smp kernel) which has no serial port for console.

>> If sysrq is still working, please try with "i8042.noaux" (this will kill
>> your touchpad, which is what i intend :-)
> 
> So I added i8042.noaux to my kernel command line, rebooted, insmodded
> intel_agp, started X, and verified no touchpad action.  Then I
> suspended, and it worked fine.  After restart, I suspended again - also
> fine.
> 
> So I think that fixed it.  But no touchpad is a bit annoying. :)

Yes, it was not thought as a fix but just for verification, since i have
seen something similar.
We have a SUSE bug for this, i believe Vojtech and Pavel will take care
of this one. Thanks for confirming, i almost started to believe i was
seeing ghosts :-)
-- 
seife
                                 Never trust a computer you can't lift.
