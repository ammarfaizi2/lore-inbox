Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263421AbREXIwD>; Thu, 24 May 2001 04:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263422AbREXIvx>; Thu, 24 May 2001 04:51:53 -0400
Received: from gate.in-addr.de ([212.8.193.158]:3856 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S263421AbREXIvr>;
	Thu, 24 May 2001 04:51:47 -0400
Date: Thu, 24 May 2001 10:51:37 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Tobias Ringstrom <tori@unhappy.mine.nu>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re:  [PATCH] drivers/net/others
Message-ID: <20010524105137.A574@marowsky-bree.de>
In-Reply-To: <200105240102.DAA27178@green.mif.pg.gda.pl> <Pine.LNX.4.33.0105241035230.10914-100000@boris.prodako.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <Pine.LNX.4.33.0105241035230.10914-100000@boris.prodako.se>; from "Tobias Ringstrom" on 2001-05-24T10:45:25
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-05-24T10:45:25,
   Tobias Ringstrom <tori@unhappy.mine.nu> said:

> >  	if (!printed_version++)
> > -		printk(version);
> > +		printk("%s", version);
> >
> >  	DMFE_DBUG(0, "dmfe_init_one()", 0);
> >
> 
> Could you please explain the purpose of this change?  To me it looks less
> efficient in both performance and memory usage.

Potentially, version might include stuff which is interpreted by printk if not
quoted - the above fixes this. Paranoia always helps ;-)

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

