Return-Path: <linux-kernel-owner+w=401wt.eu-S933145AbWLaMGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145AbWLaMGX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 07:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933148AbWLaMGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 07:06:23 -0500
Received: from mx02.qsc.de ([213.148.130.14]:53920 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933145AbWLaMGV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 07:06:21 -0500
X-Greylist: delayed 1098 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2006 07:06:21 EST
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCODE
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Sun, 31 Dec 2006 12:47:19 +0100
User-Agent: KMail/1.9.5
Cc: dmk@flex.com, wmb@firmworks.com, devel@laptop.org,
       linux-kernel@vger.kernel.org, jg@laptop.org
References: <20061230.211941.74748799.davem@davemloft.net> <45978CE9.7090700@flex.com> <20061231.024917.59652177.davem@davemloft.net>
In-Reply-To: <20061231.024917.59652177.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612311247.19224.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Sunday 31 December 2006 11:49, David Miller
	wrote: > From: David Kahn <dmk@flex.com> > Date: Sun, 31 Dec 2006
	02:11:53 -0800 > > > All we've done is created a trivial implementation
	for exporting > > the device tree to userland that isn't burdened by the
	powerpc > > and sparc legacy code that's in there now. > > So now we'll
	have _3_ different implementations of exporting > the OFW device tree
	via procfs. Your's, the proc_devtree > of powerpc, and sparc's
	/proc/openprom > > That doesn't make any sense to me, having 3 ways of
	doing the same > exact thing and making no attempt to share code at all.
	> > If you want to do something new that consolidates everything, with
	the > goal of deprecating the existing stuff, that's great! But with
	they > way you're doing this, all the sparc and powerpc implementations
	> really can't take advantage of it. > > Am I the only person who sees
	something very wrong with this? [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 31 December 2006 11:49, David Miller wrote:
> From: David Kahn <dmk@flex.com>
> Date: Sun, 31 Dec 2006 02:11:53 -0800
>
> > All we've done is created a trivial implementation for exporting
> > the device tree to userland that isn't burdened by the powerpc
> > and sparc legacy code that's in there now.
>
> So now we'll have _3_ different implementations of exporting
> the OFW device tree via procfs.  Your's, the proc_devtree
> of powerpc, and sparc's /proc/openprom
>
> That doesn't make any sense to me, having 3 ways of doing the same
> exact thing and making no attempt to share code at all.
>
> If you want to do something new that consolidates everything, with the
> goal of deprecating the existing stuff, that's great!  But with they
> way you're doing this, all the sparc and powerpc implementations
> really can't take advantage of it.
>
> Am I the only person who sees something very wrong with this?

Nope you aren't, ACK to a unified user-space export from my side as well.

Yours,

-- 
  René Rebe - ExactCODE GmbH - Europe, Germany, Berlin
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
  +49 (0)30 / 255 897 45
