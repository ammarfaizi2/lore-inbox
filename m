Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKPV6i>; Thu, 16 Nov 2000 16:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbQKPV6S>; Thu, 16 Nov 2000 16:58:18 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:63165 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129208AbQKPV6P>; Thu, 16 Nov 2000 16:58:15 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shm swapping in 2.4 again
In-Reply-To: <Pine.LNX.4.21.0011160959340.13085-100000@duckman.distro.conectiva>
	<qwwwve3ybf5.fsf@sap.com>
From: Christoph Rohland <cr@sap.com>
Date: 16 Nov 2000 22:31:00 +0100
Message-ID: <m3snord2p7.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I missed one point: we need to handle the swapout of nonattached
pages: in shm you can detach the last user and the segment with
content is still around. So we have to scan the shm objects themselves
also. Should We could do this in the same loop as we scan the mm's?

Also we have to make sure to derefence the swap entry if the last
reference is in the shm segmant table .

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
