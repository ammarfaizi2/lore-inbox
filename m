Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266441AbUAOCoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbUAOCod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:44:33 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:10149 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S266441AbUAOCoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:44:30 -0500
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
From: Matthias Hentges <mailinglisten@hentges.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040114125210.1dc50593.akpm@osdl.org>
References: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>
	 <20040114125210.1dc50593.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1074134668.6094.16.camel@mhcln02>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Jan 2004 03:44:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mit, 2004-01-14 um 21.52 schrieb Andrew Morton:
> Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
> >
> > I am experiencing data corruption on my AES cryptoloop partition under
> > recent -mm kernels (including 2.6.1-mm3).  I am unsure how long this
> > problem has existed, and I am unsure if this problem exists in the
> > mainstream kernel (I can't test it because of an aic7xxx bug in the
> > mainstream kernel).
> 
> It exists in the mainstream kernel.
> 
> I thought we had this whipped in 2.6.0-mm2, but then I removed the loop
> patches and switched to a new set.  I think I'll switch back.
> 
> It would be interesting to find out if 2.6.0-mm2 is working OK for you.

FYI: 2.6.0-mm2 fixed a nasty crypto-loop corruption bug for me.
IIRC it was encrypted w/ AES. I did not try 2.6.1-mm3, yet.

Thanks god the corruption could be fixed by running e2fsck over the
encrypted loop device using a 2.4 kernel.
A stock 2.6.0 would crash the machine when trying that.

HTH
-- 

Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian Woody. Geek by Nature, Linux by Choice

