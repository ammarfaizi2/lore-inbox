Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317999AbSGWId2>; Tue, 23 Jul 2002 04:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318000AbSGWId1>; Tue, 23 Jul 2002 04:33:27 -0400
Received: from [196.26.86.1] ([196.26.86.1]:33686 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317999AbSGWId1>; Tue, 23 Jul 2002 04:33:27 -0400
Date: Tue, 23 Jul 2002 10:54:24 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd memory corruption in 2.5.27?
In-Reply-To: <200207230957.19812.trond.myklebust@fys.uio.no>
Message-ID: <Pine.LNX.4.44.0207231053190.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002, Trond Myklebust wrote:

> Just means that some RPC message reply from the server was crap. We should 
> deal fine with that sort of thing...
> 
> AFAICS The Oops itself happened deep down in the socket layer in the part 
> which has to do with reassembling fragments into packets. The garbage 
> collector tried to release a fragment that had timed out and Oopsed.
> 
> Suggests either memory corruption or else that the networking driver is doing 
> something odd ('cos at that point in the socket layer *only* the driver + the 
> fragment handler should have touched the skb).

Thanks, that helps quite a bit, i'll see if i can pinpoint it and send it 
to the relevant people.

Thanks,
	Zwane

-- 
function.linuxpower.ca

