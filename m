Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTE0EkD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTE0EkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:40:03 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:63239 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263349AbTE0EkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:40:00 -0400
Date: Tue, 27 May 2003 06:53:02 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jason Papadopoulos <jasonp@boo.net>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030527045302.GA545@alpha.home.local>
References: <5.2.1.1.2.20030526232835.00a468e0@boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030526232835.00a468e0@boo.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 11:37:04PM -0400, Jason Papadopoulos wrote:
 
> I have the same system and run into the same problems here. The HD is a
> Fujitsu MPD3108AT (10GB ATA33/66 drive, what the machine shipped with)
> on hda. Even with the 2.4.21-rc4 kernel, the machine will not boot beyond
> the "attached ide-disk driver" message if IDE DMA is compiled in.
> 
> Whatever's going wrong doesn't require an older drive to show up.

I could finally enable DMA, only if I do it at run time :
  - enable "Generic PCI bus master DMA support"
  - disable "Use PCI DMA by default when available"
  - hdparm -d 1 /dev/every_disk

I realized that a "idex=nodma" option is really lacking here. Shouldn't we
disable IDE by default on Alpha at the moment, so that it at least boots ?
The adventurous could always use hdparm to enable it again (it survived my
39 GB save/restore).

Regards,
Willy
