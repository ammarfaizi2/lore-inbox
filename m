Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWC3NrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWC3NrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWC3NrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:47:03 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:38924 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S932212AbWC3NrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:47:02 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603301346.k2UDksdJ001794@clem.clem-digital.net>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
To: akpm@osdl.org (Andrew Morton)
Date: Thu, 30 Mar 2006 08:46:54 -0500 (EST)
Cc: clem@clem.clem-digital.net (Pete Clements),
       klassert@mathematik.tu-chemnitz.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060329210904.3e1391bb.akpm@osdl.org>
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton
  > Pete Clements <clem@clem.clem-digital.net> wrote:
  > >
  > > Quoting Andrew Morton
  > >   > 
  > >   > Oh damn.  So you're sure that 3c59x.global_enable_wol=0 actually makes the
  > >   > driver behave better?
  > >   > 
  > > Ok, new results.
  > > Built a new virgin 2.6.16.
  > > 1) able to stimulate a tx time out message
  > > 2) rebooted with 3c59x.global_enable_wol=0 on command line,
  > >    able to stimulate a tx time out message
  > > 
  > > Applied the collision statistics fix fix. Changed the extraversion
  > > in the top Makefile to preserve my baseline, also make does more
  > > work than previous. 
  > > 1) Booted and unable to stimulate a tx time out message
  > > 
  > > Rebooted to virgin 2.6.16
  > > 1) able to stimulate a tx time out message
  > > 2) rebooted with 3c59x.global_enable_wol=0 on command line,
  > >    able to stimulate a tx time out message
  > > 
  > > Rebooted to the patched driver kernel (collision statistics fix fix)
  > > 1) unable to stimulate a tx time out message.
  > > 
  > > Rebooted to virgin 2.6.16
  > > 1) able to stimulate a tx time out message
  > > 
  > > Appears that earlier results were tainted.
  > > 
  > 
  > OK, thanks.  So it looks like 3c59x-collision-statistics-fix-fix.patch is
  > the only patch which we need to return your machine to working condition?
  > 

Looks like that is the case until -git12, which Steffen has identified.
Tested on git18 (with git12 fix) and looks good.
-- 
Pete Clements 
