Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130191AbRA3MyR>; Tue, 30 Jan 2001 07:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130860AbRA3MyH>; Tue, 30 Jan 2001 07:54:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6018 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130191AbRA3Mxt>;
	Tue, 30 Jan 2001 07:53:49 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14966.47384.971741.939842@pizda.ninka.net>
Date: Tue, 30 Jan 2001 04:52:40 -0800 (PST)
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A76B72D.2DD3E640@uow.edu.au>
In-Reply-To: <3A728475.34CF841@uow.edu.au>
	<3A726087.764CC02E@uow.edu.au>
	<20010126222003.A11994@vitelus.com>
	<14966.22671.446439.838872@pizda.ninka.net>
	<3A76B72D.2DD3E640@uow.edu.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton writes:
 > BTW: can you suggest why I'm not observing any change in NFS client
 > efficiency?

As in "filecopy speed" or "cpu usage while copying a file"?

The current fragmentation code eliminates a full SKB allocation and
data copy on the NFS file data receive path in the client, CPU has to
be saved compared to pre-zerocopy or something is very wrong.

File copy speed, well you should be link speed limited as even without
the zerocopy patches you ought to have enough cpu to keep it busy.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
