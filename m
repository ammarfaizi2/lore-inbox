Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319051AbSIDFBS>; Wed, 4 Sep 2002 01:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319053AbSIDFBS>; Wed, 4 Sep 2002 01:01:18 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:33037 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319051AbSIDFBR>;
	Wed, 4 Sep 2002 01:01:17 -0400
Date: Tue, 3 Sep 2002 22:04:01 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com
Subject: Re: [BUG] 2.5.33 PCI and/or starfire.c broken
Message-ID: <20020904050401.GA4019@kroah.com>
References: <20020904035649.GC18800@holomorphy.com> <99179272.1031089797@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99179272.1031089797@[10.10.2.3]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 09:49:58PM -0700, Martin J. Bligh wrote:
> > Well, something ugly has happened no 2.5.33's PCI:
> > 
> > Somehow SCSI works, but starfire.c doesn't.
> 
> It's confused by having a PCI-PCI bridge on a quad other than 0,
> where the global and local PCI bus numbers don't line up. Rip
> the card out, or get the horrible kludge I did for 2.4, and use 
> that.

Might I suggest you port that "kludge" to the new 2.5 pci code, as the
whole goal of those large PCI changes was due to some NUMA changes that
you and Matt wanted to get into the main kernel.

Remember, you have your own file to play with now, so put all the
brain-damaged NUMA crap into it :)

thanks,

greg k-h
