Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSJUPAV>; Mon, 21 Oct 2002 11:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJUPAU>; Mon, 21 Oct 2002 11:00:20 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:36276 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261561AbSJUPAT>; Mon, 21 Oct 2002 11:00:19 -0400
Subject: Re: can chroot be made safe for non-root?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ebuddington@wesleyan.edu
In-Reply-To: <87n0pevq5r.fsf@ceramic.fifi.org>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net> 
	<87n0pevq5r.fsf@ceramic.fifi.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 16:22:12 +0100
Message-Id: <1035213732.27259.160.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 07:44, Philippe Troin wrote:
> > Is there a reason besides standards compliance that chroot() does not
> > already change directory to the chroot'd directory for root processes?
> > Would it actually break existing apps if it did change the directory?
> 
> Probably not. Make that: change the directory to chroot'd directory if
> the current working directory is outside the chroot. That is, leave
> the cwd alone if it is already inside the chroot.

Last time it was tried real apps broke.

chroot is not jail chroot is not a sandbox. Do the job right (eg the
vroot work) and it'll get a lot further

