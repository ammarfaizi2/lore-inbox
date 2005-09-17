Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVIQBSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVIQBSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 21:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVIQBSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 21:18:43 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:33390 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750804AbVIQBSm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 21:18:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iZJu5n+d6tQj5MYBQDv8VRXLn5DGK2PxAM5xnE1tw+eC8OQDk2/apWt9EnGfzaVNBafX+R+E/I0JKHUiXurenqIXaCXfVL9ujQWzmOfk5AKG5/lPbCB1dAJYXgPpcm567FOmyRnovTOWkOsUCuEoJQ15SwPQ++ZqhOPzxLq/z2I=
Message-ID: <5d8b7b90509161818a4616d9@mail.gmail.com>
Date: Sat, 17 Sep 2005 04:18:37 +0300
From: "Dr.Dre" <pharon@gmail.com>
Reply-To: pharon@gmail.com
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-rc1-mm1
Cc: kay.sievers@vrfy.org, jirislaby@gmail.com, dominik.karall@gmx.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050917001021.GA16041@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050916022319.12bf53f3.akpm@osdl.org>
	 <200509162042.07376.dominik.karall@gmx.net>
	 <432B2101.9080806@gmail.com> <20050916195903.GE22221@vrfy.org>
	 <20050916213003.GB13604@kroah.com>
	 <200509162353.j8GNrX2B007036@turing-police.cc.vt.edu>
	 <20050917001021.GA16041@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/05, Greg KH <greg@kroah.com> wrote:
> On Fri, Sep 16, 2005 at 07:53:32PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 16 Sep 2005 14:30:04 PDT, Greg KH said:
> > > > > >On Friday 16 September 2005 11:23, Andrew Morton wrote:
> > > > > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/
> >
> > > Yes, Andrew, can you please drop these patches, they will cause lots of
> > > problems with users due to the above mentioned issues.
> >
> > For those of us playing along at home -
> >
> > Would doing a 'patch -R' of all 30 patches listed in "Big input/sysfs changes"
> > be needed?
> 
> That's probably the safest.
> 
> >  Or just the 'input-prepare-to-sysfs-integration.patch' and following?
> 
> Don't really know if stuff would still build if you only reverted that
> one.
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
just a notice here: 
I had to install udev-70 to fix the "blocked udev" problem, then
noticed the  missing /dev/input/mice problem because neither gpm nor X
would start.

So I recompiled with this feature as a module ( mousedev ) and
rebooted to find udev started to create the node. ( I didn't reverse
any patches.)

Thanks.
