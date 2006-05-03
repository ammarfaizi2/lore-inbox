Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWECBYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWECBYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 21:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWECBYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 21:24:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:61648 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965064AbWECBYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 21:24:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cXNyckUvf/gik7o05/DWD1ynN1ZS481alKnJxXFJN5Zixa4LXfJJaswhhnb8Ux5nHLUaoN68EhUx3lzAxDldGdlp2bsGJm5sLeRUdKzfss2rwUAUygiyqdtULpd2+Y0AtB9F4xFXgvxk4VbrUhia/x2t+9bm3b6ThMp+R91fONI=
Message-ID: <9e4733910605021824k4b37dc96ka36f846e4f2f9813@mail.gmail.com>
Date: Tue, 2 May 2006 21:24:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Dave Airlie" <airlied@gmail.com>,
       "Arjan van de Ven" <arjan@linux.intel.com>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, pjones@redhat.com, akpm@osdl.org
In-Reply-To: <20060503001914.GA9609@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <44578C92.1070403@linux.intel.com>
	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
	 <44579028.1020201@linux.intel.com>
	 <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
	 <1146594457.32045.91.camel@laptopd505.fenrus.org>
	 <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>
	 <21d7e9970605021440s6cdc3895t57617e5fad6c5050@mail.gmail.com>
	 <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
	 <20060503001914.GA9609@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Matthew Wilcox <matthew@wil.cx> wrote:
> On Tue, May 02, 2006 at 05:52:09PM -0400, Jon Smirl wrote:
> > Have you seen this method of getting root from X?
> > http://www.cansecwest.com/slides06/csw06-duflot.ppt
> > It is referenced from Theo de Raadt interview on kerneltrap
> > http://kerneltrap.org/node/6550
>
> That's a great indication of why securelevels aren't.
> It pretty much fits the Linux model of "once you're root, you can do
> anything".  The POSIX Capabilities really don't help either.
> I suppose SELinux might be able to help, but I don't care to get into
> that discussion here ;-)

And there is the root exploit found by Coverity this week too:
http://news.yahoo.com/s/zd/20060502/tc_zd/177195

X is multiple megabytes of code needlessly running as root. If we
could convince X to use device drivers to talk to the hardware it
wouldn't need to run as root.  This is part of why I am against this
patch, it is another crutch to let X keep on running as root instead
of fixing the underlying problem.

--
Jon Smirl
jonsmirl@gmail.com
