Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbUKLVa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbUKLVa1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbUKLVa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:30:27 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:42709 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262619AbUKLVaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:30:21 -0500
Date: Fri, 12 Nov 2004 13:20:09 -0800
From: Greg KH <greg@kroah.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent I2C "dead code removal" breaks pmac sound.
Message-ID: <20041112212008.GA2256@kroah.com>
References: <20041111180902.GA8697@iram.es> <20041111182228.GA23236@kroah.com> <20041112122215.GA19147@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112122215.GA19147@iram.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 01:22:15PM +0100, Gabriel Paubert wrote:
> > Put the function back, and change the pmac.h file to delete the #define,
> > and replace the snd_pmac_keywest_write function with a real call to
> > i2c_smbus_write_block_data so things like this don't happen again.
> > 
> > Care to write a patch to do this?
> 
> It follows, along with an update of the include/linux/i2c.h to only
> declare functions that actually exist, but grepping the whole sound
> subtree shows that at least sound/oss/dmasound/tas_common.h defines 
> a few inline functions that call i2c_smbus_write_{byte,block}_data.
> 
> It might be reasonable to split it into two ChangeSets, that's
> your call.
> 
> Compiled, booted, tested and CC'ed to BenH just in case.

Applied, thanks.

greg k-h
