Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbTEUSqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 14:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTEUSqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 14:46:30 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:15786 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262294AbTEUSq1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 14:46:27 -0400
Date: Wed, 21 May 2003 20:36:16 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: David Gibson <david@gibson.dropbear.id.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030521183616.GB12677@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030517221921.GA28077@ranty.ddts.net> <20030521072318.GA12973@kroah.com> <20030521074456.GH23736@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521074456.GH23736@zax>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 05:44:56PM +1000, David Gibson wrote:
> On Wed, May 21, 2003 at 12:23:18AM -0700, Greg Kroah-Hartman wrote:
> > > +struct firmware_priv {
> > > +	char fw_id[FIRMWARE_NAME_MAX];
> > > +	struct completion completion;
> > > +	struct bin_attribute attr_data;
> > > +	struct firmware *fw;
> > > +	s32 loading:2;
> > > +	u32 abort:1;
> > 
> > Why s32 and u32?  Why not just ints for both of them?
> 
> And for that matter, I don't think there's any point using bitfields,
> 61 bits is not worth it.

 Done, I just sent updated patches.

 Thanks

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
