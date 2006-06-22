Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWFVVwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWFVVwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWFVVwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:52:09 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:26127 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750784AbWFVVwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:52:08 -0400
Date: Thu, 22 Jun 2006 23:52:05 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Eduard-Gabriel Munteanu <maxdamage@aladin.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is the x86-64 kernel size limit real?
Message-ID: <20060622215205.GA52945@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Eduard-Gabriel Munteanu <maxdamage@aladin.ro>,
	linux-kernel@vger.kernel.org
References: <20060622204627.GA47994@dspnet.fr.eu.org> <449B355C.2080805@aladin.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449B355C.2080805@aladin.ro>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 12:27:08AM +0000, Eduard-Gabriel Munteanu wrote:
> *This message was transferred with a trial version of CommuniGate(r) Pro*
> Olivier Galibert wrote:
> 
> >
> >which shows two things:
> >1- a8f5034540195307362d071a8b387226b410469f should have a x86-64 version
> >2- the limit looks entirely artificial
> >
> >So, is removing the limit prone to bite me?
> >
> >  OG.
> 
> The build system merely tries to warn you it's not going to fit on a 
> floppy disk. "bzImage" means "Big zImage", not "bz2-compressed Image", 
> so unless you're building a floppy disk, don't use zImage.

You failed to notice the "is_big_kernel ? 0x40000 : ..." part, which
means the 4Mb limit is for bzImage.  And the "die(...)" part, which
means it's not a warning but an error.

  OG.

