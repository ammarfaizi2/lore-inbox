Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbTCZJtJ>; Wed, 26 Mar 2003 04:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbTCZJtI>; Wed, 26 Mar 2003 04:49:08 -0500
Received: from gate.in-addr.de ([212.8.193.158]:37069 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id <S261529AbTCZJtI>;
	Wed, 26 Mar 2003 04:49:08 -0500
Date: Wed, 26 Mar 2003 10:59:15 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
Message-ID: <20030326095915.GL3413@marowsky-bree.de>
References: <3E81132C.9020506@pobox.com> <200303252053.h2PKrRn09596@oboe.it.uc3m.es> <3E81132C.9020506@pobox.com> <5.1.0.14.2.20030326182627.0387b1a0@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5.1.0.14.2.20030326182627.0387b1a0@mira-sjcm-3.cisco.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-03-26T18:31:31,
   Lincoln Dale <ltd@cisco.com> said:

> >Indeed, there are iSCSI implementations that do multipath and
> >failover.
> iSCSI is a transport.
> logically, any "multipathing" and "failover" belongs in a layer above it -- 

"Multipathing" on iSCSI is actually a layer below - network resiliency is
handled by routing protocols, the switching fabric etc.

> >Both iSCSI and ENBD currently have issues with pending writes during
> >network outages. The current I/O layer fails to report failed writes
> >to fsync and friends.
> these are not "iSCSI" or "ENBD" issues.  these are issues with VFS.

Yes, and it is a fairly annoying issue... In particular with ENBD, a partial
write could occur at the block device layer. Now try to report that upwards to
the write() call. Good luck.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
