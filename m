Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbTA3DOn>; Wed, 29 Jan 2003 22:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267384AbTA3DOn>; Wed, 29 Jan 2003 22:14:43 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:49796 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267383AbTA3DOm>;
	Wed, 29 Jan 2003 22:14:42 -0500
Date: Wed, 29 Jan 2003 22:26:32 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] Update PnP IDE (2/6)
Message-ID: <20030129222632.GD2246@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
	greg@kroah.com
References: <20030125201516.GA12794@neo.rr.com> <Pine.LNX.4.10.10301251824510.1744-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10301251824510.1744-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 06:28:31PM -0800, Andre Hedrick wrote:
> 
> 
> "ide_unregister" is only called if you are physically removing the
> controller.  If PNP is going to permit physical removal when the OS is
> HOT, it may be justified.  This can make a "hole" in the rest of the

At least in theory, any pnp device could be hotplugged.  Of course it depends on 
which protocol the ide drive is represented by.  ISAPnP is completely static
where as PnPBIOS, and potentially ACPI in the future, support docking stations and
other removable pnp devices.  Support for PnP hotplugging is very limited at the 
moment however it is best to design drivers around this feature so we don't have
a mess when PnP hotplugging is finally used.  Also if a pnp protocol was presented
in a removable module format, the protocol may want drivers to detach from its
devices upon module unload.  Are there any other hotpluggable ide devices and if
so how are they handled?

Also any additional comments?

Thanks,
Adam
