Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263938AbTDXVKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbTDXVKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:10:35 -0400
Received: from almesberger.net ([63.105.73.239]:26634 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263938AbTDXVKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:10:34 -0400
Date: Thu, 24 Apr 2003 18:22:28 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Matthias Schniedermeyer <ms@citd.de>, Pat Suwalski <pat@suwalski.net>,
       Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424182227.P3557@almesberger.net>
References: <20030424130151.O3557@almesberger.net> <Pine.LNX.4.44.0304241818400.1758-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304241818400.1758-100000@pnote.perex-int.cz>; from perex@suse.cz on Thu, Apr 24, 2003 at 06:26:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:
> We have emulation layer for non-ALSA mixers. This layer turns mute off 
> automagically when volume is greater than zero.

Thanks for clarifying this ! So, would you agree with the following
addition to Documentation/Changes ?

  ALSA (Advanced Linux Sound Architecture) is now the preferred
  architecture for sound support, instead of the older OSS (Open
  Sound System). Note that, in ALSA, all volume settings default
  to zero, and all channels default to being "muted".

  User space therefore needs to explicitly increase the volume,
  and "unmute" the respective audio channels before any sound
  can be heard. 

  Mixers not explicitly supporting the "mute" functionality will
  usually "unmute" sources when setting the volume to a value
  above zero.

  More information about ALSA, including configuration and OSS
  compatibility, can be found in Documentation/sound/alsa/

> Our policy is: Don't allow to users to jump from skin when default volumes 
> are invalid. Because we cannot determine the settings of an user amplifier
> (analog path), the most safe is mute everything.

I couldn't agree more.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
