Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVBJUxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVBJUxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVBJUxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:53:30 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:34228 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261625AbVBJUxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:53:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=C/IZj7oCS9rCvjF3Ey56dUCS074+znAfGDhwZ+JlBpaJumBDG5LtY3wwhE4btLKgoIQc/F02m1FrvqM+Z+pDUsmTkhF3u3vEu4Pd2uoXDzFWxkpSkQ2y0Y7GWU5yNqcAu2U9RoSinT7Uwjb51RNAHTyDJFnNHVcXV6ZGDAQ3/vM=
Message-ID: <a075431a050210125145d51e8c@mail.gmail.com>
Date: Thu, 10 Feb 2005 14:51:44 -0600
From: "Jack O'Quin" <jack.oquin@gmail.com>
Reply-To: "Jack O'Quin" <jack.oquin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc3-mm2
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com,
       Chris Wright <chrisw@osdl.org>, Ingo Molnar <mingo@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[direct reply bounced, resending via gmail]

Andrew Morton <akpm@osdl.org> writes:

> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Feb 10, 2005 at 02:35:08AM -0800, Andrew Morton wrote:
> > > 
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm2/
> > > 
> > > 
> > > - Added the mlock and !SCHED_OTHER Linux Security Module for the audio guys.
> > >   It seems that nothing else is going to come along and this is completely
> > >   encapsulated.
> > 
> > Even if we accept a module that grants capabilities to groups this
> > isn't fine yet because it only supports two specific capabilities
> > (and even those two in different ways!) instead of adding generic
> > support to bind capabilities to groups.
> 
> I'm sure that got discussed somewhere in the 1000 emails which flew past
> last time.  Jack?

[adding cc: for the main discussion participants]

Most people felt that a more general capabilities module would be nice
to have.  But, no one offered any code, or volunteered to work on it.

I have no objection to that approach, but am not willing or able to do
it myself.  My opinion is that expanding the scope of the LSM would
significantly increase its security risk.  That job needs to be done
very carefully, by someone with a deep understanding of the kernel's
internal use of capabilities.

Perhaps, Christoph's suggestion could become part of a more general
module, which might replace the RT-LSM in the 2.8 timeframe.  Our LSM
is a modest solution aimed at solving the immediate needs of audio
developers and users with minimal impact on kernel security or
correctness.
