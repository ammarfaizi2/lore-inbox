Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277259AbRJDWub>; Thu, 4 Oct 2001 18:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277261AbRJDWuV>; Thu, 4 Oct 2001 18:50:21 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45010 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277259AbRJDWuN>; Thu, 4 Oct 2001 18:50:13 -0400
Date: Thu, 4 Oct 2001 15:49:11 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>, "David S. Miller" <davem@redhat.com>,
        rgooch@ras.ucalgary.ca, arjan@fenrus.demon.nl,
        linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011004154911.D1245@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011004175526.C18528@redhat.com> <Pine.LNX.4.40.0110041530170.1022-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0110041530170.1022-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Thu, Oct 04, 2001 at 03:35:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 03:35:35PM -0700, Davide Libenzi wrote:
> > Right.  Plus, the original mail mentioned that it was hitting all 8
> > CPUs, which is a pretty good example of braindead scheduler behaviour.
> 
> There was a discussion about process spinning among idle CPUs a couple of
> months ago.
> Mike, did you code the patch that stick the task to an idle between the
> send-IPI and the idle wakeup ?
> At that time we simply left the issue unaddressed.

I believe the 'quick and dirty' patches we came up with substantially
increased context switch times for this benchmark (doubled them).
The reason is that you needed to add IPI time to the context switch
time.  Therefore, I did not actively pursue getting these accepted. :)
It appears that something in the 2.2 scheduler did a much better
job of handling this situation.  I haven't looked at the 2.2 code.
Does anyone know what feature of the 2.2 scheduler was more successful
in keeping tasks on the CPUs on which they previously executed?
Also, why was that code removed from 2.4?  I can research, but I
suspect someone here has firsthand knowledge.

-- 
Mike Kravetz                                  kravetz@us.ibm.com
IBM Peace, Love and Linux Technology Center
