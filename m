Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUDLPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUDLPY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 11:24:57 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:58629 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261998AbUDLPYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 11:24:55 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: "Ivica Ico Bukvic" <ico@fuse.net>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Date: Mon, 12 Apr 2004 17:19:52 +0200
User-Agent: KMail/1.5.2
Cc: "'Thomas Charbonnel'" <thomas@undata.org>, <ccheney@debian.org>,
       <linux-pcmcia@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
       "'Russell King'" <rmk+lkml@arm.linux.org.uk>,
       <alsa-devel@lists.sourceforge.net>,
       "'Tim Blechmann'" <TimBlechmann@gmx.net>,
       David Hinds <dhinds@sonic.net>
References: <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>
In-Reply-To: <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404121719.52103.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 April 2004 03:39, Ivica Ico Bukvic wrote: 
> **I've noted that when I use:
> 
> setpci -s a.0 0x81.b
> 
> after changing the value to 0xd0 (with setpci -s a.0 0x81.b=d0) it would
> tell me that it was equal to f0, yet the "hexdump -v /proc/bus/pci/00/0a.0"
> would tell me it was d0 after all (see the log below).
> 

it's a single bit change from 0xd0 to 0xf0. it's bit 13 of the system control
register at 0x80. it's the socket activity bit that is read-clear. this means
writing to it has no effect, reading it clears the content. so the behavior
is normal...

