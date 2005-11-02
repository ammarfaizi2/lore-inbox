Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbVKBHyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVKBHyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbVKBHyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:54:25 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:6301 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932630AbVKBHyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:54:25 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: usbatm@lists.infradead.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Date: Wed, 2 Nov 2005 08:54:22 +0100
User-Agent: KMail/1.8.3
Cc: Greg KH <greg@kroah.com>, matthieu castet <castet.matthieu@free.fr>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
References: <4363F9B5.6010907@free.fr> <20051101224510.GB28193@kroah.com>
In-Reply-To: <20051101224510.GB28193@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511020854.22799.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > + * sometime hotplug don't have time to give the firmware the
> > + * first time, retry it.
> > + */
> > +static int sleepy_request_firmware(const struct firmware **fw, 
> > +		const char *name, struct device *dev)
> > +{
> > +	if (request_firmware(fw, name, dev) == 0)
> > +		return 0;
> > +	msleep(1000);
> > +	return request_firmware(fw, name, dev);
> > +}
> 
> No, use the async firmware download mode instead of this.  That will
> solve all of your problems.

Hi Greg, it looks like you understand what the problem is here.  Could
you please explain to us lesser mortals ;)

Thanks,

Duncan.
