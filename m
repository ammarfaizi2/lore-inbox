Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTEUHee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbTEUHea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:34:30 -0400
Received: from dp.samba.org ([66.70.73.150]:35565 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261506AbTEUHb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:31:56 -0400
Date: Wed, 21 May 2003 17:44:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg KH <greg@kroah.com>
Cc: Manuel Estrada Sainz <ranty@debian.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>
Subject: Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030521074456.GH23736@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Greg KH <greg@kroah.com>, Manuel Estrada Sainz <ranty@debian.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Simon Kelley <simon@thekelleys.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
	Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>
References: <20030517221921.GA28077@ranty.ddts.net> <20030521072318.GA12973@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521072318.GA12973@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 12:23:18AM -0700, Greg Kroah-Hartman wrote:
> > +struct firmware_priv {
> > +	char fw_id[FIRMWARE_NAME_MAX];
> > +	struct completion completion;
> > +	struct bin_attribute attr_data;
> > +	struct firmware *fw;
> > +	s32 loading:2;
> > +	u32 abort:1;
> 
> Why s32 and u32?  Why not just ints for both of them?

And for that matter, I don't think there's any point using bitfields,
61 bits is not worth it.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
