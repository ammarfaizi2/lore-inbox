Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTJQAF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 20:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTJQAF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 20:05:26 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:51076 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S263259AbTJQAFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 20:05:21 -0400
From: David Lang <david.lang@digitalinsight.com>
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 16 Oct 2003 16:53:12 -0700 (PDT)
Subject: Re: Transparent compression in the FS
In-Reply-To: <20031016235811.GE29279@pegasys.ws>
Message-ID: <Pine.LNX.4.58.0310161648190.4792@dlang.diginsite.com>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random>
 <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14>
 <20031016230448.GA29279@pegasys.ws> <3F8F2A32.90101@pobox.com>
 <20031016235811.GE29279@pegasys.ws>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, jw schultz wrote:

> Date: Thu, 16 Oct 2003 16:58:11 -0700
> From: jw schultz <jw@pegasys.ws>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Transparent compression in the FS
>
> On Thu, Oct 16, 2003 at 07:30:58PM -0400, Jeff Garzik wrote:
> > jw schultz wrote:
> > >Because each hash algorithm has different pathologies
> > >multiple hashes are generally better than one but their
> > >effective aggregate bit count is less than the sum of the
> > >separate bit counts.
> >
> > I was coming to this conclusion too...  still, it's safer simply to
> > handle collisions.
>
> And because, in a filesystem, you have to handle collisions
> you balance the cost of the hash quality against the cost of
> collision.  A cheap hash with low colission rate is probably
> better than an expensive hash with a near-zero colission
> rate.

true, but one advantage of useing multiple hashes is that once you already
have the data in the CPU you can probably do multiple cheap hashes for the
same cost as a single one (the same reason that calculating a checksum is
essentially free if you are already having the CPU touch the data) when
the CPU is 12x+ faster then the memory bus you have a fair bit of CPU time
available for each byte of data that you are dealing with.

David Lang
