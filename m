Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314227AbSD0PBD>; Sat, 27 Apr 2002 11:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314228AbSD0PBD>; Sat, 27 Apr 2002 11:01:03 -0400
Received: from ns.suse.de ([213.95.15.193]:31501 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314227AbSD0PBC>;
	Sat, 27 Apr 2002 11:01:02 -0400
Date: Sat, 27 Apr 2002 17:01:01 +0200
From: Dave Jones <davej@suse.de>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH} SMBIOS support
Message-ID: <20020427170101.L14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3CCA1462.9010405@acm.org> <20020427051820.D14743@suse.de> <3CCAB976.9010109@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 09:45:10AM -0500, Corey Minyard wrote:
 > >Any reason for initialising it there instead of using a subsys_initcall
 > >from smbios.c ?
 > Can you control other orders within the subsystem?

Use different types of _initcall. See include/linux/init.h

 > Other things that come later in this subsystem might need it
 > Actually, it might be needed before this, I've moved it to before the PCI
 > initialization, 
 > since this contains interrupt information and possible PCI information.

Ok, I overlooked the relationship of PCI to SMBIOS.
As pci is initialised with subsys_initcall, you could initialise
earlier by using core_initcall.


 > > > +	char str[80];
 > >Worth adding a if (len>80) return here in case of crap biosen?
 > >Or am I overly paranoid?
 > It's printing 16 hex characters every time, so it doesn't matter.  And 
 > it's only debug code, anyway.

Ok.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
