Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVDRQUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVDRQUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVDRQUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:20:17 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:39917 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262076AbVDRQUH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:20:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZHGPW73vWTadYzzhHGk9e5HUGk/aE3KSRRXVeI1BNUIoyqynpLrp9Qct0V6q+MBspiTFcH18ruAtvPrdszh7SSB3YMGUiYJ4+dmLtJkbKv0up+uVpewOim0CUxvd+bgaYI1hyV6ghCWqTKAJxDt2PW5eSWYb0EnpaoPI9rd19hM=
Message-ID: <6533c1c90504180920693aa204@mail.gmail.com>
Date: Mon, 18 Apr 2005 12:20:06 -0400
From: Igor Shmukler <igor.shmukler@gmail.com>
Reply-To: Igor Shmukler <igor.shmukler@gmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: intercepting syscalls
Cc: riel@redhat.com, thehazard@gmail.com, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050418081726.7d3125bd.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
	 <6533c1c905041512411ec2a8db@mail.gmail.com>
	 <e1e1d5f40504151251617def40@mail.gmail.com>
	 <6533c1c905041512594bb7abb4@mail.gmail.com>
	 <Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com>
	 <6533c1c905041807487a872025@mail.gmail.com>
	 <20050418081726.7d3125bd.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,

> And 'nobody' has submitted patches that handle all of the described
> problems...
> 
> 1.  racy
> 2.  architecture-independent
> 3.  stackable (implies/includes unstackable :)
> 
> You won't get very far in this discussion without some code...

I agree that if races disallow safe loading unloading it's a serious
problem. I'll get there pretty soon and I would be very to submit a
patch. It makes sense to hide interface if currently there is no safe
way to use it. I understand.

I don't think that drivers have to be architecture independent. Why is
this a problem?

Same regarding stackability. We have a module that works well with
other modules that intercept system calls just not on Linux. There are
caveats - not every module will just work with every other module. But
same problem is with networking protocols. It took time until IPsec
vendors worked out glitches.

Usually, it's not necessary to load/unload module to/from the middle
of the stack all the time.

I would even agree that it might be beneficial to develop guidelines
for developing stackable modules that intercept system calls, but I
think that reasons beyond races are of less importance.

For RH or SuSE it's very different. If they need something like this
done, a patch to the kernel and they are good to go. Simple folk still
has to make software that works with standard kernels and we have to
be given API that allows us to do this.

Igor
