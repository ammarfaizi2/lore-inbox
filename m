Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUFKEw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUFKEw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 00:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbUFKEw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 00:52:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16596 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263752AbUFKEw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 00:52:27 -0400
Date: Fri, 11 Jun 2004 05:52:24 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       rtjohnso@eecs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040611045224.GO12308@parcelfarce.linux.theplanet.co.uk>
References: <E1BYXuJ-0006vd-RU@sc8-sf-list1.sourceforge.net> <20040611063107.0c62e2f8.luca.risolia@studio.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040611063107.0c62e2f8.luca.risolia@studio.unibo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 06:31:07AM +0200, Luca Risolia wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> >                    unsigned int cmd, void* arg)
> >  {
> >  	struct w9968cf_device* cam;
> > +	void __user *user_arg = (void __user *)arg;
> 
> The right place to apply this patch is in video_usercopy().

The right thing to do is to kill video_usercopy() as ugly piece of crap.
