Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVJFRow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVJFRow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVJFRow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:44:52 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:38527 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751262AbVJFRov convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:44:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QHnofR1i8vKs3eKwyqFDwHe6hKqXeTAqFod3zCyFPdLyaTg79a00iySICFU571CjYuQ35mvuyqieBOZRmPeAkhcLVf80G4z01h4hST+3zRbhqjX4trWWlsfHUN0SiccL/uMwfJP/TJT9h9ZnbDQQaWdQMxSfc6/c2w+r+o18lAU=
Message-ID: <5bdc1c8b0510061044l4fc25619j3cdf3d0c1f89a98f@mail.gmail.com>
Date: Thu, 6 Oct 2005 10:44:50 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rc3-rt9 - a few xruns misses
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1128620286.14584.43.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510051615hfd77ba8pab7ee07bde13ffd4@mail.gmail.com>
	 <20051006083043.GB21800@elte.hu>
	 <5bdc1c8b0510060900m721296h53ac1d0f0fc12351@mail.gmail.com>
	 <1128615988.14584.38.camel@mindpipe>
	 <5bdc1c8b0510060930y5648eacdm376178069dcd3958@mail.gmail.com>
	 <5bdc1c8b0510061006p5339d5f3ke0079c172e15b04f@mail.gmail.com>
	 <1128620286.14584.43.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Thu, 2005-10-06 at 10:06 -0700, Mark Knecht wrote:
> > Is it that rt priorities are not set up correctly? Or is it something else?
>
> Yes.  JACK is running at a lower priority on your system than all the
> IRQ threads.  So disk activity is likely to cause xruns.  In qjackctl's
> Setup screen set "Priority" to 80.
>
> Lee
>
>
OK, done. Testing will likely take a while to be sure that this is enough.

Is there anything I should be doing with the priority of my HDSP ISR?
That change back on 2.6.9-rtX was like a light switch for turning off
xruns at that time.

Thanks,
Mark
