Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTFXXCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTFXXCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:02:40 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:11016 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S263462AbTFXXC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:02:29 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200306242316.TAA28624@clem.clem-digital.net>
Subject: Re: 2.5.73 -- Uninitialised timer! (i386)
In-Reply-To: <16120.50188.29.739261@gargle.gargle.HOWL> from Mikael Pettersson at "Jun 24, 2003 11:35: 7 pm"
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Tue, 24 Jun 2003 19:16:33 -0400 (EDT)
Cc: clem@clem.clem-digital.net, akpm@digeo.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mikael Pettersson
  > Pete Clements writes:
  >  > Quoting Andrew Morton
  >  >   > 
  >  >   > Well it beats me.  That timer is clearly initialised OK.
  >  >   > 
  >  >   > What compiler version are you using?  Can you try
  >  >   > a different one>?
  >  > 
  >  > Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
  >  > gcc version 2.95.4 20011002 (Debian prerelease)
  >  > 
  >  > Only compiler currently installed.  Have four systems (3 single
  >  > processor, 1 dual) all running Debian--woody with same versions.
  >  > On the UP systems, will see several of these traces during boot.
  >  > After that, it is very seldom (0 to 3 in 12 hours). Have seen none
  >  > on the SMP system.  Recompiled one of the UP systems with SMP
  >  > enabled and no longer saw the trace during boot and post. Have
  >  > not seen this prior to 2.5.73.
  > 
  > Apply the patch below (which I posted to LKML yesterday btw).
  > 2.5.73 incorrectly removed the workaround needed to prevent
  > gcc-2.95.x from miscompiling spinlocks on UP (they become
  > empty structs, and gcc-2.95.x has problems with those).
  > 
  > /Mikael
  > 

Patch applied, cleared up the traces.

-- 
Pete Clements 
clem@clem.clem-digital.net
