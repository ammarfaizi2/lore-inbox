Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318101AbSIAVts>; Sun, 1 Sep 2002 17:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318118AbSIAVts>; Sun, 1 Sep 2002 17:49:48 -0400
Received: from p50887EBD.dip.t-dialin.net ([80.136.126.189]:31970 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318101AbSIAVt2>; Sun, 1 Sep 2002 17:49:28 -0400
Date: Sun, 1 Sep 2002 15:53:53 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: Oliver Neukum <oliver@neukum.name>, <linux-kernel@vger.kernel.org>
Subject: Re: question on spinlocks
In-Reply-To: <20020901210504.A22882@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.44.0209011553140.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 1 Sep 2002, Ralf Baechle wrote:
> On Sun, Sep 01, 2002 at 07:27:53PM +0200, Oliver Neukum wrote:
> > is the following sequence legal ?
> > 
> > spin_lock_irqsave(...);
> > ...
> > spin_unlock(...);
> > schedule();
> > spin_lock(...);
> > ...
> > spin_unlock_irqrestore(...);
> 
> No; spin_lock_irqsave/spin_unlock_irqrestore and spin_lock/spin_unlock
> have to be used in matching pairs.

If it was his least problem! He'll run straight into a "schedule w/IRQs 
disabled" bug.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

