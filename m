Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSLGXh4>; Sat, 7 Dec 2002 18:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbSLGXhz>; Sat, 7 Dec 2002 18:37:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:63967 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264954AbSLGXhu>;
	Sat, 7 Dec 2002 18:37:50 -0500
Message-ID: <3DF28811.F6580BA6@digeo.com>
Date: Sat, 07 Dec 2002 15:45:21 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
References: <3DF2781D.3030209@pobox.com> <20021207.144004.45605764.davem@redhat.com> <3DF27EE7.4010508@pobox.com> <3DF2844C.F9216283@digeo.com> <20021207233745.GE3183@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 23:45:22.0378 (UTC) FILETIME=[B526C2A0:01C29E4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> 
> #define __cacheline_start   struct { } ____cacheline_aligned;

That will generate a warning on faster^Wolder versions of gcc.

mnm:/home/akpm> gcc t2.c
t2.c:11: warning: unnamed struct/union that defines no instances
t2.c:15: warning: unnamed struct/union that defines no instances
mnm:/home/akpm> gcc -v 
Reading specs from /usr/local/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/specs
gcc version 2.95.3 20010315 (release)
