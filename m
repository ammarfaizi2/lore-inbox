Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266851AbUHISdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266851AbUHISdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266849AbUHISaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:30:55 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:46780 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266845AbUHIS3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:29:20 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Paul Jackson <pj@sgi.com>
Subject: 2.6.8-rc3: vfat problem [was: Re: [Problem] 2.6.8-rc3: usb-storage devices are read-only (NOT related to iocharset)]
Date: Mon, 9 Aug 2004 20:39:12 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200408082157.35469.rjwysocki@sisk.pl> <200408082208.02328.rjwysocki@sisk.pl> <20040809060359.5be7c11f.pj@sgi.com>
In-Reply-To: <20040809060359.5be7c11f.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408092039.12606.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 of August 2004 15:03, Paul Jackson wrote:
> I've been mounting my vfat /boot/efi elilo (this is on an SN2, which
> uses ia64 boot conventions) boot partition read-write by doing:
>
> 	mount -o remount,rw /boot/efi
>
> after it comes up mounted read-only.  Does that help?  This is on
> 2.6.8-rc2-mm2.

Yes, it does, but you have to be root to do this (ie overkill).  However, it 
turns out that the "first" mount works if you specify both codepage and 
iocharset at the same time even if they do not fit each to other (eg cp437 
and iso8859-2).  It looks like a bug to me.

Thanks,
RJW

PS
BTW, I think the mount should be reported as "ro" if it's not _really_ "rw".

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
