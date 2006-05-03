Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWECBaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWECBaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 21:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWECBaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 21:30:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:62371 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965065AbWECBaF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 21:30:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZKwFNyrCVo40RdJrwUKXYZvZqqaApgxg/IU9msHHqsQAanIjXFLyFgX/vp/DRHSEu4kKfp76EdmtTgzyzJoAy6tEdFZ8e7hvTCyT/b4aKmc4fHg0HcOmKGW6j8/VZL00lSjHGV4giGoXTXN1zN9d8sSfJKy12kF4hJbLVCq+nGQ=
Message-ID: <21d7e9970605021830t62e8c57dw38035b418d42eeb5@mail.gmail.com>
Date: Wed, 3 May 2006 11:30:04 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Matthew Wilcox" <matthew@wil.cx>,
       "Arjan van de Ven" <arjan@linux.intel.com>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, pjones@redhat.com, akpm@osdl.org
In-Reply-To: <9e4733910605021824k4b37dc96ka36f846e4f2f9813@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
	 <44579028.1020201@linux.intel.com>
	 <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
	 <1146594457.32045.91.camel@laptopd505.fenrus.org>
	 <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>
	 <21d7e9970605021440s6cdc3895t57617e5fad6c5050@mail.gmail.com>
	 <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
	 <20060503001914.GA9609@parisc-linux.org>
	 <9e4733910605021824k4b37dc96ka36f846e4f2f9813@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > That's a great indication of why securelevels aren't.
> > It pretty much fits the Linux model of "once you're root, you can do
> > anything".  The POSIX Capabilities really don't help either.
> > I suppose SELinux might be able to help, but I don't care to get into
> > that discussion here ;-)
>
> And there is the root exploit found by Coverity this week too:
> http://news.yahoo.com/s/zd/20060502/tc_zd/177195
>
> X is multiple megabytes of code needlessly running as root. If we
> could convince X to use device drivers to talk to the hardware it
> wouldn't need to run as root.  This is part of why I am against this
> patch, it is another crutch to let X keep on running as root instead
> of fixing the underlying problem.
>

That root hole is weeks old by now, just got to yahoo today, what you
say is true, however we can't just turn all the things in Linux off
that make X run as root, and then say go fix X we don't care. There
are steps to be taken, unfortunately they are neither pretty or can be
done really quickly....

Dave/
