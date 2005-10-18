Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVJRPMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVJRPMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 11:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVJRPMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 11:12:13 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:25502 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750795AbVJRPMN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 11:12:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BwmkawThPTR+9g/MSmUUcd2/DhrmcKklyDHQejBFNIxw24WIHiFOQd7kuTNEO2GGt8KPkuwfdHW8tEPeYYyBt3YyPRNk76kK4zNhbJNlyD24+pkmMqfnd0+aTeEuvrMheu0EksAoosmatd/xN++x8rutS0m1BGgF5K/ecd4P0SA=
Message-ID: <b6c5339f0510180812p3ff6d0b1ia204b28c4e50186d@mail.gmail.com>
Date: Tue, 18 Oct 2005 11:12:12 -0400
From: Bob Copeland <email@bobcopeland.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: file system block size
Cc: Roushan Ali <roushan.ali@gmail.com>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1129646212.15136.37.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <30b4e63b0510172252x1dfca9f2l75bb0f183aecf7bb@mail.gmail.com>
	 <20051019001218.B5830881@wobbly.melbourne.sgi.com>
	 <1129646212.15136.37.camel@imp.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Indeed, it makes everything harder.  Have a look at ntfs in the kernel
> which has to cope with file system block sizes between 512 bytes and
> several hundred kiB (at least they are in powers of two thank
> goodness...).  You end up not being able to use a lot of generic
> functions as you for example need to lock multiple pages which needs to
> be ordered correctly, etc...  If you look at the latest -mm kernel, the
> ntfs driver there has file write(2) support for any cluster size and you
> will see an example of the multiple page locking problem solution there.

Any chance this will make it into common code?  I also need it for my
filesystem driver (here: http://bobcopeland.com/karma/).  So far I've
only done read side which is not too bad, but as you say writing makes
things complicated.

That, and the extent-supporting mpage_readpages would make me a happy person.

-Bob
