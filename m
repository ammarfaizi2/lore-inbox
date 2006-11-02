Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752451AbWKBTkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbWKBTkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbWKBTkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:40:46 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:1122 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752451AbWKBTko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:40:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V7avs8VEO4CYFkrZGCNxsuUCWxnj3JmK/Oud0lmDTArYcm25zbiPOimE6dLJtAuPI/4Roh11LUwXHPIXyz3ECxSJJOO+yut9Cn+gAzasLlLayLN3HwAlBtMz9nRHO/2XlBLWemtMHMejFbERjTq1AB6kT3x3pNqf0iR1UmwFPhA=
Message-ID: <5c49b0ed0611021140u360342f2v1e83c73d03eea329@mail.gmail.com>
Date: Thu, 2 Nov 2006 11:40:43 -0800
From: "Nate Diller" <nate.diller@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Cc: LKML <linux-kernel@vger.kernel.org>, "Oleg Verych" <olecom@flower.upol.cz>,
       "Pavel Machek" <pavel@ucw.cz>, "David Miller" <davem@davemloft.net>,
       "Ulrich Drepper" <drepper@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, "Zach Brown" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Chase Venters" <chase.venters@clientec.com>,
       "Johann Borck" <johann.borck@densedata.com>
In-Reply-To: <20061102062158.GC5552@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1154985aa0591036@2ka.mipt.ru> <1162380963981@2ka.mipt.ru>
	 <20061101130614.GB7195@atrey.karlin.mff.cuni.cz>
	 <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz>
	 <20061101162403.GA29783@2ka.mipt.ru>
	 <slrnekhpbr.2j1.olecom@flower.upol.cz>
	 <20061101185745.GA12440@2ka.mipt.ru>
	 <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com>
	 <20061102062158.GC5552@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Wed, Nov 01, 2006 at 06:12:41PM -0800, Nate Diller (nate.diller@gmail.com) wrote:
> > Indesiciveness has certainly been an issue here, but I remember akpm
> > and Ulrich both giving concrete suggestions.  I was particularly
> > interested in Andrew's request to explain and justify the differences
> > between kevent and BSD's kqueue interface.  Was there a discussion
> > that I missed?  I am very interested to see your work on this
> > mechanism merged, because you've clearly emphasized performance and
> > shown impressive results.  But it seems like we lose out on a lot by
> > throwing out all the applications that already use kqueue.
>
> It looks you missed that discussion - freebsd kqueue has fields in the
> kevent structure which have diffent sizes in 32 and 64 bit environments.

Are you saying that the *only* reason we choose not to be
source-compatible with BSD is the 32 bit userland on 64 bit arch
problem?  I've followed every thread that gmail 'kqueue' search
returns, which thread are you referring to?  Nicholas Miell, in "The
Proposed Linux kevent API" thread, seems to think that there are no
advantages over kqueue to justify the incompatibility, an argument you
made no effort to refute.  I've also read the Kevent wiki at
linux-net.osdl.org, but it too is lacking in any direct comparisons
(even theoretical, let alone benchmarks) of the flexibility,
performance, etc. between the two.

I'm not arguing that you've done a bad design, I'm asking you to brag
about the things you improved on vs. kqueue.  Your emphasis on
unifying all the different event types into one interface is really
cool, fill me in on why that can't be effectively done with the kqueue
compatability and I also will advocate for kevent inclusion.

NATE
