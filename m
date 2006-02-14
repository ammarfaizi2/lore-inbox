Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWBNSeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWBNSeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWBNSeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:34:37 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29916 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030347AbWBNSeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:34:36 -0500
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Adrian Bunk <bunk@stusta.de>, sfrench@samba.org,
       linux-cifs-client@lists.samba.org, samba-technical@lists.samba.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602141911470.32490@yvahk01.tjqt.qr>
References: <20060214135016.GC10701@stusta.de>
	 <Pine.LNX.4.61.0602141911470.32490@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 13:33:21 -0500
Message-Id: <1139942002.11659.133.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 19:12 +0100, Jan Engelhardt wrote:
> >"Complete freeze" is:
> >[..]
> >  is played in an endless loop by the sound chip
> 
> Sounds like a portion of code disabled interrupts?

Anything that locks the machine while sound is playing will cause the
last period of audio to repeat in an endless loop, because the DMA
engine keeps running but the soundcard isn't getting new data.  It's not
specific to interrupt disabling.

Isn't it fortunate that network cards don't work this way? ;-)

Lee

