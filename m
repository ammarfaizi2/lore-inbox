Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSGYNRT>; Thu, 25 Jul 2002 09:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSGYNRT>; Thu, 25 Jul 2002 09:17:19 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:62460 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313181AbSGYNRS>; Thu, 25 Jul 2002 09:17:18 -0400
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: martin@dalecki.de, Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10207250526000.4719-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10207250526000.4719-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 15:33:22 +0100
Message-Id: <1027607602.9885.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 13:30, Andre Hedrick wrote:
> 
> EEK!
> 
> Alan, how are you going to sync to access to the shared HBA registers if
> the lock is decoupled from the main loop?  Since there are general
> register mucking abouts during data transfers, iirc the behavors of the
> CMD640B I use for testing.  You have me a little close to the edge of my
> seat on concern.

>From inspection I don't believe this is a problem. Also for example they
have not been synchronized for some time on VLB with no apparent
problems. If there are cases where PCI config needs synchronizing here
(which I dont believe is the case) then the caller should be holding the
io_request lock anyway, and seems to

