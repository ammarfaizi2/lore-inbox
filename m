Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265448AbRFVPtM>; Fri, 22 Jun 2001 11:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265451AbRFVPtC>; Fri, 22 Jun 2001 11:49:02 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:27908 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S265448AbRFVPsv>; Fri, 22 Jun 2001 11:48:51 -0400
Date: Sat, 23 Jun 2001 03:48:49 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Dag Wieers <dag@wieers.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Should __FD_SETSIZE still be set to 1024 ?
Message-ID: <20010623034849.A3728@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0106221631500.27761-100000@horsea.3ti.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106221631500.27761-100000@horsea.3ti.be>; from dag@wieers.com on Fri, Jun 22, 2001 at 04:59:36PM +0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2001 at 04:59:36PM +0200, Dag Wieers wrote:

    Is there a reason for __FD_SETSIZE to be 1024 in
    linux/posix_types.h and gnu/types.h ?
    Why can't we increase this number by default ?

It might break stuff, like things that link with code that assumes it
is only 1024.

    Shouldn't it be set to the real limit of the kernel ?

Nah... the kernel limit is 1024^2 --- you don't want to use select
anywhere near that.

    (And let applications define their own limit if there is a need
    for one ?)

Well, squid and friends do this anyhow.

Not only that, using a greatly increased value should be a run-time
decision, lest you want your code to break on early 2.2.x kernels and
before.




  --cw
