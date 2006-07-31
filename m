Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWGaUGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWGaUGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWGaUGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:06:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:3313 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932308AbWGaUGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:06:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HZUwWGCJuqEduSFNiLXyhXxocAYiLaqQNz5AAeWWK6uiiIcvAOy+7kUzyu5Zc2m9jiV2qaJ0uT8B3vLpIMDSODD0v+kvxqDnb/6Wo5MFvCWaRzODRGfnftknaySJMS9VX58MNgCl8f0rZDoEW8AVYxZyKCFH2GQ9MyRhxtpCoNg=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, reiser@namesys.com
Subject: Re: reiser4: maybe just fix bugs?
Date: Mon, 31 Jul 2006 22:06:42 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200607311617.k6VGH3YH009055@laptop13.inf.utfsm.cl>
In-Reply-To: <200607311617.k6VGH3YH009055@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607312206.42240.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 18:17, Horst H. von Brand wrote:
> > Not too bad when compared to other FSes, but still.
> 
> How did you compare?

Because as I can see on lkml, other FSes also have deadlock-on-oom
bugs. Linus also talked about ext3 inodes being insanely big.

> > When singled out, none of these things are bad enough to hold off
> > inclusion. However, combined impact of _both_ of them
> > did upset maintainers enough.
> 
> Plus a, lets say, less than cooperative overall attitude, and a marked
> tendency to try to sneak changes in by political arm-twisting.

Yes, this is present to a degree.
 
> > Frankly, on the first problem I think that you are right, Hans, and
> > putting plugins into VFS _now_ makes little sense because we can't know
> > whether anybody will ever want to have plugins for some other FS, so
> > requiring reiser people to do all the shuffling _now_ for questionable
> > gain is simply not fair. It can be done later if needed.
> 
> You are wrong. ReiserFS has no "right" to be allowed into the kernel.

JBD is factored out. So far it was a wasted effort - nobody uses
JBD except ext3.
--
vda
