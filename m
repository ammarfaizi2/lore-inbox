Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUEFR3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUEFR3f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUEFR3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:29:35 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:64648
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261712AbUEFR3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:29:32 -0400
From: Rob Landley <rob@landley.net>
To: Daniele Venzano <webvenza@libero.it>, Ken Ashcraft <ken@coverity.com>
Subject: Re: [PATCH] sis900 fix (Was: [CHECKER] Resource leaks in driver shutdown functions)
Date: Thu, 6 May 2004 12:23:40 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <3580.171.64.70.92.1083609961.spork@webmail.coverity.com> <20040504084326.GA11133@gateway.milesteg.arr>
In-Reply-To: <20040504084326.GA11133@gateway.milesteg.arr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405061223.40942.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 May 2004 03:43, Daniele Venzano wrote:
> Thank you for the spotting, the sis900 dirver was really missing a call
> to netif_device_detach in sis900_suspend.
>
> Attached is a trivial patch that fixes the issue.
>
> The sis900 driver is currently unmaintained (the MAINTAINERS address
> bounces), but I'm willing to take the work, since I know somewhat the
> code and I wrote the power management functions.
>
> I no one stands up, I'll send a patch to MAINTAINERS later on.
>
> Bye.

Does this fix the problem where you unplug the cat 5 cable from an SiS900 and 
then plug it back in (toggling the MII tranciever link detect status and all 
that), and the device goes positively mental until you reboot the system?  
(Packets randomly dropped or delayed for up to 15 seconds, and arriving out 
of sequence with horrible impacts on performance?)

I tried pursuing this when I first noticed it circa 2.4.4, but as you say, the 
driver is unmaintained and I haven't got specs (or any clue about) the 
chipset...

Rob

