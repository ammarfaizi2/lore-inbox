Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVA0HrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVA0HrY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVA0HrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:47:24 -0500
Received: from gate.perex.cz ([82.113.61.162]:44477 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S262091AbVA0HrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:47:17 -0500
Date: Thu, 27 Jan 2005 08:46:27 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Biker <biker@villagepeople.it>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [BUG] 2.6.11-rc2 ALSA
In-Reply-To: <20050126233524.232dcca0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0501270837240.1743@pnote.perex-int.cz>
References: <20050126233524.232dcca0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, Andrew Morton wrote:

> Hello list,
> after upgrading to 2.6.11-rc2 my soundcard doesn't work anymore:
> 
> I get this message during initialization of ALSA:
> 
> /usr/sbin/alsactl: set_control:805: warning: name mismatch (External 
> Amplifier/Headphone Jack Sense) for control #26
> 
> The soundcard is integrated on my thinkpad centrino notebook (R50), lspci 
> reports this:
> 
> Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
> AC'97 Audio Controller (rev 01)
> 
> If I boot back to 2.6.10 the PCM control has the volume set to zero, but 
> readjusting it to a normal value brings everything back to normal.

It's probably already fixed in our CVS and ALSA BK tree:

=====
revision 1.69
date: 2005/01/17 13:47:20;  author: tiwai;  state: Exp;  lines: +14 -2
Summary: Fix silent output on some machines with AD1981x codecs

Fixed the default state of "Headphone Jack Sense" switch on AD1981x
codecs.  Setting this on affects the output of some machines (e.g.
Thindpads).

The default value is set on only hardwares which are known to work.
=====

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
