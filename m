Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWHIXJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWHIXJZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWHIXJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:09:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:50054 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751431AbWHIXJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:09:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IqNJptTPFhSal+vr1H+b6CE26ibAJn5eSW2CJnVstgv0O4LkRtlGIWCr1Hr6RG+BFXQeHIIq1yHV+X6h0c2NRxQqRB4G2VpaSGgU329o9biZhGF7pZWCe61U6M9PnqUx4eB2yLaUmRhFd4fE7hBzcL95vQYxOITt9K2xFpzwonQ=
Message-ID: <62b0912f0608091609q6b3c6c4ev2d287060fa209@mail.gmail.com>
Date: Thu, 10 Aug 2006 01:09:02 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Duane Griffin" <duaneg@dghda.com>
Subject: Re: ext3 corruption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e9e943910608091527t3b88da7eo837f6adc1e1e6f98@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com>
	 <62b0912f0608091347u8b86d40q3679991e9e16526f@mail.gmail.com>
	 <e9e943910608091527t3b88da7eo837f6adc1e1e6f98@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duane Griffin wrote:
> > How close to 1-1 does "-n" relate to non-"-n" ?
> >
> > For example, does e2fsck take into consideration the changes it would
> > have done itself in regular mode when it proceeds to the next problem
> > and/or phase of a -n operation?
>
> It corresponds perfectly to you answering "no" to all questions :)
> Sorry, I don't have a much better answer than that.

A good answer, even if it's one that can be found in the manual :-).

> > If it doesn't, then that command is, well, totally useless.
>
> That is too strong.

I don't think so.

If it doesn't take into account own changes, then the -n command is
unable to produce even a slightly accurate resemblence of what would
happen if I did a real run.

And that's about the only use case I can come up with for -n...

> You should be able to get an idea how severe the damage
> is, at least.

If it's complete inaccurate, I can't trust the result, so that doesn't
help me much, if any.

> From a quick read of the code it looks like your problem
> is related to dodgy data in the superblock, and e2fsck will attempt to
> recover & continue by reading the backup superblock.

Thanks a lot for checking !

I wonder then, will it write back this alternate superblock?

Is there anything I can do to control the process, like:
Do a test mount with one of the alternate superblocks?
Tell fsck to test a specific superblock; afterwards tell fsck to use a
specific superblock?

That would be useful.

> It does that regardless of whether you use -n,
> so in that respect at least it will operate in the
> same way as "normal" operation.

Ok, that's very good to know, thanks a lot.
