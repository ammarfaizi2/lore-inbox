Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbREODy7>; Mon, 14 May 2001 23:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262615AbREODyt>; Mon, 14 May 2001 23:54:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41147 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262607AbREODyr>;
	Mon, 14 May 2001 23:54:47 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15104.43139.354492.914572@pizda.ninka.net>
Date: Mon, 14 May 2001 20:54:43 -0700 (PDT)
To: God <atm@sdk.ca>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: TCP capture effect :: estimate queue length ?
In-Reply-To: <Pine.LNX.4.21.0105142339470.23642-100000@scotch.homeip.net>
In-Reply-To: <20010514234604.A4694@gruyere.muc.suse.de>
	<Pine.LNX.4.21.0105142339470.23642-100000@scotch.homeip.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


God writes:
 > Speaking of queues on routers/servers, does such a util exist that would
 > measure (even a rough estimate), what level of congestion (queueing) is
 > happening between point A and B ?

Not that I know of, but it is funny you mention this because this is
basically the kind of calculation the TCP Vegas congestion avoidance
scheme attempts to make.  At it's core, it is trying to estimate the
size of router queues from local machine to remote machine based upon
"congestion events" (packet drop, etc.).

Later,
David S. Miller
davem@redhat.com
