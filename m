Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbTDQDgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 23:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTDQDgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 23:36:46 -0400
Received: from dp.samba.org ([66.70.73.150]:22461 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262599AbTDQDgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 23:36:45 -0400
Date: Thu, 17 Apr 2003 13:48:25 +1000
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'ranty@debian.org'" <ranty@debian.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: firmware separation filesystem (fwfs)
Message-ID: <20030417034825.GG9219@zax>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	'Alan Cox' <alan@lxorguk.ukuu.org.uk>,
	"'ranty@debian.org'" <ranty@debian.org>,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
References: <A46BBDB345A7D5118EC90002A5072C780C262E38@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C262E38@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Apr 16, 2003 at 07:00:00PM -0700, Perez-Gonzalez, Inaky wrote:
> 
> > From: David Gibson [mailto:david@gibson.dropbear.id.au]
> > 
> > Incidentally another approach that also avoids nasty ioctl()s would be
> > to invoke the userland helper with specially set up FD 1, which lets
> > the kernel capture the program's stdout. 
> 
> I think this makes too many assumptions specially taking into
> account that most hotplug stuff are shell scripts - they are
> probably going to be writing all kinds of stuff to stdout.
> 
> With the risk of repeating myself (again) and being a PITA,
> I really think it'd be easier to copy the firmware file to a 
> /sysfs binary file registered by the device driver during 
> initialization; then the driver can wait for the file to be
> written with a valid firmware before finishing the init
> sequence. The infrastructure is already there (or isn't ... 
> is it?).

Well, I guess that would be basically what I mean by an equivalent
sysfs thing.  I haven't looked at the binary file support in sysfs, as
yet.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
