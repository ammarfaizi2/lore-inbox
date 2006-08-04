Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161408AbWHDUmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161408AbWHDUmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161405AbWHDUmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:42:16 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7590 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161408AbWHDUmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:42:16 -0400
Message-Id: <200608042042.k74KgEjI020387@laptop13.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Subject: Re: Checksumming blocks? [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion] 
In-Reply-To: Message from Tomasz Torcz <zdzichu@irc.pl> 
   of "Fri, 04 Aug 2006 13:41:25 +0200." <20060804114125.GA10814@irc.pl> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Fri, 04 Aug 2006 16:42:14 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 04 Aug 2006 16:42:14 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz <zdzichu@irc.pl> wrote:
> On Thu, Aug 03, 2006 at 07:25:19PM -0400, Russell Leighton wrote:
> > 
> > If the software (filesystem like ZFS or database like Berkeley DB)  
> > finds a mismatch for a checksum on a block read, then what?
> > 
> > Is there a recovery mechanism, or do you just be happy you know there is 
> > a problem (and go to backup)?
> 
>   ZFS readsthis block again from different mirror, and if checksum is
> right -- returns good data to userspace and rewrites failed block with
> good data.
> 
>   Note, that there could be multiple mirrors, either physically (like
> RAID1) or logically (blocks could be mirrored on different areas of the
> same disk; some files can be protected with multiple mirrors, some left
> unprotected without mirrors).

Murphy's law will ensure that the important files are unprotected. And the
1st Law of Disk Drives (they are always full) will ensure that there are no
mirrored pieces anyway...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
