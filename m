Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVCBFPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVCBFPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 00:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVCBFPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 00:15:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23194 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262178AbVCBFPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 00:15:13 -0500
Date: Wed, 2 Mar 2005 05:15:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, mike.miller@hp.com,
       linux-kernel@vger.kernel.org, mochel@osdl.org, akpm@osdl.org,
       eric.moore@lsil.com, linux-scsi@vger.kernel.org
Subject: Re: cciss CSMI via sysfs for 2.6
Message-ID: <20050302051503.GA11194@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, mike.miller@hp.com,
	linux-kernel@vger.kernel.org, mochel@osdl.org, akpm@osdl.org,
	eric.moore@lsil.com, linux-scsi@vger.kernel.org
References: <20050216164512.GA5734@beardog.cca.cpqcorp.net> <20050218194628.GA24583@infradead.org> <20050218200552.GC20171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218200552.GC20171@kroah.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 12:05:52PM -0800, Greg KH wrote:
> On Fri, Feb 18, 2005 at 07:46:28PM +0000, Christoph Hellwig wrote:
> > >  /*
> > > + * sysfs stuff
> > > + * this should be moved to it's own file, maybe cciss_sysfs.h
> > > + */
> > > +
> > > +static ssize_t cciss_firmver_show(struct device *dev, char *buf)
> > > +{
> > > +	ctlr_info_t *h = dev->driver_data;
> > > +        return sprintf(buf,"%c%c%c%c\n", h->firm_ver[0], h->firm_ver[1],
> > > +                                h->firm_ver[2], h->firm_ver[3]);
> > > +}
> > 
> > I really wish we had a common firmver release attribut in the driver
> > core, as mentioned in the fc transport class thread.  Greg?
> 
> For a device?  It seems a huge overkill to add this attribute for
> _every_ device in the system, when only a small minority can actually
> use it.  Just put it as a default scsi or transport class attribute
> instead.

it's not related to scsi or a transport at all.  I'd rather have the
notation of optional generic attributes so that every driver that
wantsa to publish it does so in the same way.

