Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbTLaQbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 11:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbTLaQbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 11:31:36 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:37117
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S265198AbTLaQbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 11:31:35 -0500
Date: Wed, 31 Dec 2003 11:31:34 -0500
From: Omkhar Arasaratnam <omkhar@rogers.com>
To: Arthur Othieno <a.othieno@bluewin.ch>
Cc: emoenke@gwdg.de, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] drivers/cdrom/isp16.c check_region() fix - take 2
Message-ID: <20031231163133.GA3367@omkhar.ibm.com>
References: <20031229220916.GA17210@omkhar.ibm.com> <20031231023501.GB1982@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031231023501.GB1982@mars>
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [67.60.208.120] using ID <omkhar@rogers.com> at Wed, 31 Dec 2003 11:30:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 03:35:01AM +0100, Arthur Othieno wrote:
> On Mon, Dec 29, 2003 at 05:09:16PM -0500, Omkhar Arasaratnam wrote:
> >  	printk(KERN_INFO
> >  	       "ISP16: cdrom interface set up with io base 0x%03X, irq %d, dma %d,"
> >  	       " type %s.\n", isp16_cdrom_base, isp16_cdrom_irq,
> >  	       isp16_cdrom_dma, isp16_cdrom_type);
> >  	return (0);
> > +:out
> > +	release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
> > +	return (-EIO);
> >  }
> 
> s/:out/out:/

Good catch ;-)
