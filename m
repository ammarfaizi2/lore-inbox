Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbRGPQNp>; Mon, 16 Jul 2001 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267445AbRGPQNg>; Mon, 16 Jul 2001 12:13:36 -0400
Received: from sncgw.nai.com ([161.69.248.229]:24995 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267446AbRGPQNX>;
	Mon, 16 Jul 2001 12:13:23 -0400
Message-ID: <XFMail.20010716091650.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <OFE9275D2B.C8E7F6FC-ON85256A8B.00370192@pok.ibm.com>
Date: Mon, 16 Jul 2001 09:16:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Hubertus Franke <frankeh@us.ibm.com>
Subject: Re: CPU affinity & IPI latency
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16-Jul-2001 Hubertus Franke wrote:
> 
> David, you are preaching to choir.
> 
> One can not have it both ways, at least without "#ifdef"s.
> As Mike stated, we made the decision to adhere to current scheduling
> semantics
> purely for the purspose of comparision and increased adaptation chances.
> As shown with the LoadBalancing addition to MQ, there are simple ways to
> relax and completely eliminate the feedback between the queues, if one so
> desires.
> 
> As for the solutions you proposed for the "switching problem", namely the
> wakeup
> list. I don't think you want a list here. A list would basically mean that
> you
> would need to walk it and come up with a single decision again. I think
> what
> I proposed, namely a per-CPU reschedule reservation that can be overwritten
> taking
> PROC_CHANGE_PENALTY or some form of it into account, seems a better
> solution.
> Open to discussions...

No, when you're going to decide ( reschedule_idle ) which idle to spin out, you
can inspect the wake list and, based on the content of the list, one can take a
better decision about which idle to wake.
I think that a list, instead of a single task pointer, is a more open solution
that could drive to a more sophisticated choice of the CPU to stock the task to.




- Davide

