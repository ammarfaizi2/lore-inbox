Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbULWMCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbULWMCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 07:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbULWMCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 07:02:39 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:12427 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261214AbULWMCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 07:02:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uh5ywT1qzC/lXaiA5ej3yXn2AS62V3vEIbiCIQt/eBqSgeSIemHIx/KAq7NOyczLQ/UVZ42gcPhu8FksSNBCqnJ3ApqbI0pi3+SJq4Wz4QKHgVV0idIhE7K+ZGnvn4xOh9chyqZ2m4CHfa2yv15PmOYsOvsOM3wrhCEU/IhRjZY=
Message-ID: <11f564b9041223040240200b03@mail.gmail.com>
Date: Thu, 23 Dec 2004 17:32:31 +0530
From: Paramveer Singh <kernel.mail@gmail.com>
Reply-To: Paramveer Singh <kernel.mail@gmail.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.21 opteron 32 Gig RAM has 10k block writes/sec on running posgresql 7.4.6 disk i/o intensive app
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041223070757.GZ771@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <11f564b9041222225638905557@mail.gmail.com>
	 <20041223070757.GZ771@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks Wli!
the update seems to have worked and the same situation has not arisen again.

regards,
ps


On Wed, 22 Dec 2004 23:07:57 -0800, William Lee Irwin III
<wli@holomorphy.com> wrote:
> On Thu, Dec 23, 2004 at 12:26:48PM +0530, Paramveer Singh wrote:
> > we are using a RedHat AS3 U3 box (2.4.21-4.ELsmp) to run a very
> > intensive database app which does a _huge_ number of inserts durnig
> > the data generation phase. However, we are noticing a unexpected
> > performance drops with user cpu utilization numbers falling to near 0.
> > most of the cpu is used up in iowait.
> > CPU states:  cpu    user    nice  system    irq  softirq  iowait    idle
> >           total    2.0%    0.0%    7.6%   0.0%     0.0%  362.4%   27.2%
> > /proc/slabinfo showed huge numbers in buffer_head. The line was:
> > buffer_head       4908452 4962249    200 260854 261171    1 : 16000 4000
> 
> Please try to reproduce on a more recent RHEL3, e.g. RHEL3-U4 released
> today.
> 
> 
> -- wli
>
