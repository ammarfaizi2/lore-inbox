Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271769AbRIUIDh>; Fri, 21 Sep 2001 04:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271836AbRIUID1>; Fri, 21 Sep 2001 04:03:27 -0400
Received: from [195.66.192.167] ([195.66.192.167]:52232 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271769AbRIUIDI>; Fri, 21 Sep 2001 04:03:08 -0400
Date: Fri, 21 Sep 2001 11:01:12 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1978861221.20010921110112@port.imtp.ilyichevsk.odessa.ua>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS daemons in D state for 2 minutes at shutdown
In-Reply-To: <shswv2tpyvq.fsf@charged.uio.no>
In-Reply-To: <3531863216.20010920164639@port.imtp.ilyichevsk.odessa.ua>
 <shswv2tpyvq.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Trond,

Thursday, September 20, 2001, 8:15:21 PM, you wrote:
TM>      > Hi NFS folks, I am still fighting witn nfsd/lockd not dying
TM>      > upon killall5.  (they are stuck in D state for 2 mins and then
TM>      > die with "rpciod: active tasks at shutdown?!" at console)

TM>      > I found out that nfsd and lockd die as expected when I use
TM>      > modified killall5 which do not SIGSTOP all tasks before killing
TM>      > them.

TM> killall5 is a bad idea as a method for killing nfsd/lockd. You are
TM> better off using something more targeted so you can ensure the correct
TM> ordering.

Well, do you mean I must update my shutdown script whenever I install
something new just because this "something new" does not like
standard, well accepted method of signalling apps to exit?
Come on, this sounds like The Wrong Way.

TM> If you kill the portmapper before the nfs/lockd daemons have finished
TM> unregistering their services then the above behaviour is completely
TM> normal.

So, why modified killall5 does the job?

Why not make portmapper+NFS daemons killable by TERM, giving them
the chance to do proper cleanups rather than abrupt KILL?
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


