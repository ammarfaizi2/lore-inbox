Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272576AbTHEIPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 04:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272574AbTHEIPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 04:15:55 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:10397
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272576AbTHEIPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 04:15:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Oliver Neukum <oliver@neukum.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 18:20:59 +1000
User-Agent: KMail/1.5.3
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, mingo@elte.hu,
       felipe_alfaro@linuxmail.org
References: <200308050207.18096.kernel@kolivas.org> <200308051726.14501.kernel@kolivas.org> <200308051012.12951.oliver@neukum.org>
In-Reply-To: <200308051012.12951.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308051820.59266.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 18:12, Oliver Neukum wrote:
> Am Dienstag, 5. August 2003 09:26 schrieb Con Kolivas:
> > On Tue, 5 Aug 2003 16:03, Andrew Morton wrote:
> > > We do prefer that TASK_UNINTERRUPTIBLE processes are woken promptly so
> > > they can submit more IO and go back to sleep.  Remember that we are
> > > artificially leaving the disk head idle in the expectation that the
> > > task will submit more I/O.  It's pretty sad if the CPU scheduler leaves
> > > the anticipated task in the doldrums for five milliseconds.
> >
> > Indeed that has been on my mind. This change doesn't affect how long it
> > takes to wake up. It simply prevents tasks from getting full interactive
> > status during the period they are doing unint. sleep.
>
> If you take that to its logical conclusion, such tasks should be woken
> immediately. Likewise, the io scheduler should be notified when you know
> that the task won't do io or will do other io, like waiting on character
> devices, go paging out or terminate.

Every experiment I've tried at putting tasks at the start of the queue instead 
of the end has resulted in some form of starvation so should not be possible 
for any user task and I've abandoned it.

Con

