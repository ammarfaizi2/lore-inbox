Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbTFCMj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbTFCMj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:39:28 -0400
Received: from unthought.net ([212.97.129.24]:62928 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264983AbTFCMjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:39:21 -0400
Date: Tue, 3 Jun 2003 14:52:47 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS io errors on transfer from system running 2.4 to system running 2.5
Message-ID: <20030603125247.GD14947@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Michael Frank <mflt1@micrologica.com.hk>,
	linux-kernel@vger.kernel.org
References: <200306031912.53569.mflt1@micrologica.com.hk> <20030603122411.GB14947@unthought.net> <200306032043.28141.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200306032043.28141.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 08:43:28PM +0800, Michael Frank wrote:
> On Tuesday 03 June 2003 20:24, Jakob Oestergaard wrote:
> > > When doing rsync or cp _from_ system running 2.4 _to_ system running 2.5
> > > get Input/output error errors with random files.
> >
> > Do you use soft mounts?
> 
> Yes

Then this is why you get the error

> 
> >
> > If so, try hard instead. soft will fail, sooner or later.
> 
> I don't like hard mounts because these do not timeout.

You get what you ask for, then:  timeouts

> 
> Also, this does not explain why 2.5 > 2.4 (and 2.4 > 2.4) is OK - _never_ had any problem  

Leave it running for a million years, and I'm sure a sporadic error will
show up in those two situations as well.

You just now found a case where sporadic errors show up more often.

soft-mount = fail upon (sporadic) error
hard-mount = retry (forever or until interrupted if used with 'intr') upon error

I always use hard,intr so that I can manually interrupt hanging jobs,
but also know that they do not randomly fail just because a few packets
get dropped on my network.  This seems to be the common setup, as far as
I know.

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
