Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWACOlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWACOlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWACOlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:41:32 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:46801 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932379AbWACOlb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:41:31 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Tue, 3 Jan 2006 14:41:27 +0000
User-Agent: KMail/1.9
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <200601031347.19328.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0601031530240.436@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601031530240.436@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601031441.27519.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 14:38, Jan Engelhardt wrote:
> >It strikes me that it's a bit of a chicken and egg problem. Vendors are
> > still releasing applications on Linux that support only OSS, partly due
> > to ignorance, but mostly because ALSA's OSS compatibility layer allows
> > them to lazily ignore the ALSA API and target all cards, old and new.
> >
> >Additionally, we can't get rid of OSS compatibility until pretty much all
> >hardware has an ALSA driver, and (inferred from your comment) we can't get
> >rid of OSS drivers until nothing supports OSS, because the whole of the
> > ALSA stuff is a bit larger...
>
> By OSS compatibility, do you mean the OSS PCM emulation layer (/dev/dsp)? I
> think that should be kept. That way, legacy apps keep working, especially
> unmaintained binary-only things like Unreal Tournament 1.
>
> The OSS emulation does not depend on the OSS tree (CONFIG_SOUND_PRIME), so
> I cannot quite follow your second paragraph - we should not remove OSS
> compat. anytime.

Andi made this point and I agree. I'm just making the point that people should 
see it as exactly that -- a legacy compatibility layer. It should not be seen 
as a "way out" for vendors looking to write generic DSP software.

The problem with using OSS compatibility, at least on this machine with ALSA 
1.0.9, is that if you use it you automatically lose the software mixing 
capabilities of ALSA, so it really is less than ideal.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
