Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVAMHaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVAMHaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 02:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVAMHaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 02:30:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18321 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261189AbVAMHaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 02:30:01 -0500
Date: Thu, 13 Jan 2005 08:28:02 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Lee Revell <rlrevell@joe-job.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050113072802.GB13195@devserv.devel.redhat.com>
References: <20050111214152.GA17943@devserv.devel.redhat.com> <200501112251.j0BMp9iZ006964@localhost.localdomain> <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us> <20050112074906.GB5735@devserv.devel.redhat.com> <87oefuma3c.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oefuma3c.fsf@sulphur.joq.us>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 06:44:23PM -0600, Jack O'Quin wrote:
> Arjan van de Ven <arjanv@redhat.com> writes:
> 
> > On Tue, Jan 11, 2005 at 07:43:29PM -0600, Jack O'Quin wrote:
> >> Lexicographic ambiguity: Lee and Paul are using "trash" for things
> >> like installing a hidden suid root shell or co-opting sendmail into an
> >> open spam relay.  Arjan just means crashing the system which forces
> >> reboot to run fsck.
> >
> > I actually meant data corruption.
> 
> Are you concerned about something different from the "normal" risk of
> data corruption when the kernel panics or someone trips over the power
> cord?

yes; the "normal" risk is time limited, eg the kernel will wait at most 30
seconds before writing back your dirty data, 5 seconds for ext3 actually.
With the "RT-abuse" hang, this 30 second thing goes on hold (because it's
done from those kernel threads that cause you those hickups in sound :-) and
you can starve a far longer period of time.. which may well mean a far
larger dataset not hitting the disk.
