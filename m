Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbTCZHVj>; Wed, 26 Mar 2003 02:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261498AbTCZHVi>; Wed, 26 Mar 2003 02:21:38 -0500
Received: from sj-core-2.cisco.com ([171.71.177.254]:37603 "EHLO
	sj-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S261493AbTCZHVi>; Wed, 26 Mar 2003 02:21:38 -0500
Message-Id: <5.1.0.14.2.20030326182627.0387b1a0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 26 Mar 2003 18:31:31 +1100
To: Matt Mackall <mpm@selenic.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] ENBD for 2.5.64
Cc: Jeff Garzik <jgarzik@pobox.com>, ptb@it.uc3m.es,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030326055525.GA20244@waste.org>
References: <3E81132C.9020506@pobox.com>
 <200303252053.h2PKrRn09596@oboe.it.uc3m.es>
 <3E81132C.9020506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:55 PM 25/03/2003 -0600, Matt Mackall wrote:
> > Yeah, iSCSI handles all that and more.  It's a behemoth of a
> > specification.  (whether a particular implementation implements all that
> > stuff correctly is another matter...)
>
>Indeed, there are iSCSI implementations that do multipath and
>failover.

iSCSI is a transport.
logically, any "multipathing" and "failover" belongs in a layer above it -- 
typically as a block-layer function -- and not as a transport-layer function.

multipathing belongs elsewhere -- whether it be in MD, LVM, EVMS, DevMapper 
-- or in a commercial implementation such as Veritas VxDMP, HDS HDLM, EMC 
PowerPath, ...

>Both iSCSI and ENBD currently have issues with pending writes during
>network outages. The current I/O layer fails to report failed writes
>to fsync and friends.

these are not "iSCSI" or "ENBD" issues.  these are issues with VFS.


cheers,

lincoln.

