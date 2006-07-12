Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWGLKIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWGLKIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 06:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWGLKIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 06:08:51 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:5857 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751231AbWGLKIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 06:08:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Wed, 12 Jul 2006 12:09:05 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607120034.01339.rjw@sisk.pl> <200607120900.49828.ncunningham@linuxmail.org>
In-Reply-To: <200607120900.49828.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607121209.05766.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 12 July 2006 01:00, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 12 July 2006 08:34, Rafael J. Wysocki wrote:
> > On Wednesday 12 July 2006 00:01, Nigel Cunningham wrote:
> > > On Wednesday 12 July 2006 07:54, Rafael J. Wysocki wrote:
> > > > On Tuesday 11 July 2006 14:45, Nigel Cunningham wrote:
> > > > > Was that 10% speedup on suspend or resume, or both? With LZF, I see
> > > > > approximately double the speed with both reading and writing:
> > > >
> > > > I was not referring to the speedup of writing and/or reading.
> > > >
> > > > The exercise was to measure the time needed to suspend the system and
> > > > get it back in a responsive state.  I measured the time elapsed between
> > > > triggering the suspend and the moment at which I could switch between
> > > > some applications in X without any noticeable lag due to faulting in
> > > > some pages (that is a bit subjective, I must admit, but I was willing
> > > > to show that bigger images make substantial difference).
> > > >
> > > > I tested uswsusp with compression (LZF) and two image sizes: 120 MB and
> > > > (IIRC) about 220 MB on a 256 MB box.  The result of the measurement for
> > > > the 120 MB image has always been greater than for the 220 MB image, but
> > > > the difference has never been greater than 10%.
> > >
> > > Ah ok. Are you sure you're getting that sort of throughput with LZF
> > > though - if you're not, you might be underestimating the advantage.
> >
> > Certainly I don't get that kind of speedup for writing.  For reading I do.
> 
> Hmm. I would have expected it to be the other way round, since I guess you 
> need to do the reading synchronously - or do you read the image, then 
> decompress it? (I'm reading and decompressing at the same time, using 
> readahead to avoid waiting for pages all the time).

We're doing something like you are, but I think we're using some other option
in LZF, because the resulting image size is 30-40% of the uncompressed one.
That's better for encryption later on, but obviously not for speed.

Greetings,
Rafael
