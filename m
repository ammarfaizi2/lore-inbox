Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVBPHEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVBPHEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 02:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVBPHEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 02:04:48 -0500
Received: from mx2.elte.hu ([157.181.151.9]:24741 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261771AbVBPHEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 02:04:45 -0500
Date: Wed, 16 Feb 2005 08:04:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, agk@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper: multipath
Message-ID: <20050216070437.GA18912@elte.hu>
References: <20050211171506.GX10195@agk.surrey.redhat.com> <20050211173143.GA11278@infradead.org> <20050211133632.2277fed9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211133632.2277fed9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +EXPORT_SYMBOL(dm_register_path_selector);
> >  > +EXPORT_SYMBOL(dm_unregister_path_selector);
> > 
> >  I though we agreed to only allow GPL'ed path selectors at OSDL?
> 
> (OSDL?)
> 
> Yup, this should be _GPL.  Anything which uses these exports is a
> derived work, isn't it?

i'd not say it that categorically. I'd rather say that any module which
uses these exports gains access to a wide range of GPL-licensed internal
functionality of the kernel under the condition that the module declares
that it is license-compatible with the GPL.

While the use of such functionality very likely means that the module is
derived work, even if it's not derived work (e.g. consider the following
absurd corner-case: it is a short, trivial binary blob that was
brute-force generated and blackbox tested to be a kernel module that
happens to load fine) the module still has to follow the rules and must
not circumvent the technological protection measure.

(this fine distinction may or may not matter to you legally or
otherwise, depending on your geographical coordinates and other
factors.)

	Ingo
