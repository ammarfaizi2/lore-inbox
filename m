Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132879AbRDKSvo>; Wed, 11 Apr 2001 14:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132912AbRDKSvb>; Wed, 11 Apr 2001 14:51:31 -0400
Received: from elf.ihep.su ([194.190.161.106]:43785 "EHLO elf.ihep.su")
	by vger.kernel.org with ESMTP id <S132889AbRDKSvE>;
	Wed, 11 Apr 2001 14:51:04 -0400
Date: Wed, 11 Apr 2001 22:50:51 +0400
From: "Eugene B. Berdnikov" <berd@elf.ihep.su>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
Message-ID: <20010411225051.B19364@elf.ihep.su>
In-Reply-To: <20010411011901.A2029@fay.elferno.lo> <200104111635.UAA08446@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200104111635.UAA08446@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Apr 11, 2001 at 08:35:51PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 08:35:51PM +0400, kuznet@ms2.inr.ac.ru wrote:
> To get this on new socket you should leave session idle for >2hours
> until the first keeplaive. After this it will never probe under
> any curcumstances. The bug was that keepalive corrupts state of timer
> and probe0 timer is not started after this.

 Maybe. However, I did not understand, have you any reasonable explanation
 how can I get such a socket. Indeed, I have been dealing with active
 connection: I traced a squid redirector at a peak time of users web
 activity. Several lines of log per second. That's why I was surprised
 when this window become frozen.

 If your model does not cover such situation, pls, take it in mind. :)
-- 
 Eugene Berdnikov
