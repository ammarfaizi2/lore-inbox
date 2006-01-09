Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWAID61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWAID61 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWAID61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:58:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:32689 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751239AbWAID60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:58:26 -0500
Date: Sun, 8 Jan 2006 19:53:23 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean Delvare <khali@linux-fr.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: i2c/ smbus question
Message-ID: <20060109035323.GA2824@kroah.com>
References: <1136673364.30123.20.camel@localhost.localdomain> <20060108113013.34fe5447.khali@linux-fr.org> <1136761102.30123.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136761102.30123.87.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 09:58:22AM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2006-01-08 at 11:30 +0100, Jean Delvare wrote:
> 
> > The i2c_smbus_write_i2c_block_data wrapper function used to be defined,
> > but was removed in 2.6.10-rc2 together with a couple other similar
> > wrappers [1] on request by Adrian Bunk, the reason being that they had
> > no user back then. I was a bit reluctant at first, but we finally agreed
> > with Adrian to remove the functions, and to reintroduce them later if
> > they were ever needed.
> 
> Argh... Adrian, sometimes I hate you ;-)
> 
> > So, if you need i2c_smbus_write_i2c_block_data(), we can easily
> > resurrect it. See the patch below. I made the new version a bit faster
> > (I hope) than the original by using memcpy, please confirm it works for
> > you.
> 
> Seems to work. Greg, would you mean boucing that to Linus asap (if you
> are ok with it of course) ? I have a pile of patch about to hit him via
> the powerpc merge git tree and I'll "fix" some of the mac drivers in
> there to use that wrapper, so without that patch, g5 won't build ;)

Sure, Jean, care to resend it to me, as it's now lost in my archives
somewhere :)

thanks,

greg k-h
