Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTDYRdT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 13:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTDYRdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 13:33:19 -0400
Received: from almesberger.net ([63.105.73.239]:40717 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263298AbTDYRdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 13:33:18 -0400
Date: Fri, 25 Apr 2003 14:44:49 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pat Suwalski <pat@suwalski.net>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030425144449.X3557@almesberger.net>
References: <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net> <20030424213632.GK30082@mail.jlokier.co.uk> <20030424205515.T3557@almesberger.net> <3EA87BE1.1070107@suwalski.net> <20030425074116.V3557@almesberger.net> <1051265094.5573.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051265094.5573.8.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Apr 25, 2003 at 11:04:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The OSS audio drivers ac97 code now starts up with record muted. 

Okay, so I guess this will then cover all cases ? (Changebar
marks OSS addition.)

  ALSA (Advanced Linux Sound Architecture) is now the preferred
  architecture for sound support, instead of the older OSS (Open
  Sound System). Note that, in ALSA, all volume settings default
| to zero, and all channels default to being "muted". Also some
| OSS drivers in 2.5 initialize certain mixer settings to zero.
  
  User space therefore needs to explicitly increase the volume,
  and "unmute" the respective audio channels before any sound
  can be heard.
  
  Mixers not explicitly supporting the "mute" functionality will
  usually "unmute" sources when setting the volume to a value
  above zero.
  
  More information about ALSA, including configuration and OSS
  compatibility, can be found in Documentation/sound/alsa/

(I guess a simpler rule would be "if there's no sound, check the
mixer - and you don't want to know why you have to do this" :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
