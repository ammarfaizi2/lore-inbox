Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281067AbRKOVV3>; Thu, 15 Nov 2001 16:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281070AbRKOVVU>; Thu, 15 Nov 2001 16:21:20 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26910 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S281067AbRKOVVH> convert rfc822-to-8bit; Thu, 15 Nov 2001 16:21:07 -0500
Date: Thu, 15 Nov 2001 21:22:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small sym-2 fix
In-Reply-To: <20011115183811.F1902-100000@gerard>
Message-ID: <Pine.LNX.4.21.0111152105500.1588-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2001, Gérard Roudier wrote:
> 
> To be serious, the right fix is to have some logical page be some power of
> two of the physical page when the physical page is too small. Can we hope
> Linux-2.5 to allow this?

It's certainly doable.  I have an i386 patch against 2.4.7 which did that,
MMUPAGE_SIZE 4kB distinguished from PAGE_SIZE 4kB, 8kB, 16kB or 32kB
(but 64kB truncates to 0 in unsigned short b_size, doesn't work so well!);
while still presenting the 4kB EXEC_PAGESIZE to userspace.

It's a bit tedious working through each kernel update, to decide which
PAGEs should be MMUPAGEs etc, and I didn't see an immediate reward of
a huge leap in performance, so I haven't kept it up to date since then.

Hugh

