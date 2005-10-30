Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVJ3Syl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVJ3Syl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVJ3Syl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:54:41 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:6520 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932210AbVJ3Syk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:54:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lVqHN+ddy5xBr6B3MyZwsq7lH/r5VbZ7s4k4X6KKvFLGcSGnZjAwcVQt9APU36jJuI3oJLyWw5nRkOky7PpBHxxzHeVeQjOt9ykib+y7byIwrX0L0gf2s+oi5g6wOgLDSpNa/Pe5H5yQcrtuzMzL6LWJ7uL/Lg9Ikd5N9lJNSmw=
Message-ID: <2c0942db0510301054j64e650efqe416e14fc1e3bff2@mail.gmail.com>
Date: Sun, 30 Oct 2005 11:54:37 -0700
From: Ray Lee <madrabbit@gmail.com>
Reply-To: ray@madrabbit.org
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: BIND hangs with 2.6.14
Cc: linux-kernel@vger.kernel.org, ray-lk@madrabbit.org
In-Reply-To: <20051030023557.GA7798@uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051030023557.GA7798@uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We upgraded one of our servers (single Opteron, running 64-bit kernel but
> 32-bit userland) from 2.6.11.9 to 2.6.14 (with the additional NFS patches,
> but that shouldn't really matter) today, and now BIND seems to hang every few
> hours. (Everything on the machine except for the kernel is Debian sarge, so
> we're using BIND 9.2.4 and glibc 2.3.2, with NPTL.) I'm unsure what's really
> happening, but it doesn't respond to any requests at all, a plain strace on
> the process gives nothing, ltrace gives nothing, and it doesn't use any CPU.

It seems a not unreasonable assumption that 2.6.13 works okay, or
there would have been reports of unhappiness (though that is a pure
assumption). Since it only takes a few hours to get the problem to
occur, is it feasible to try to bisect the problem space by testing
some snapshots between 2.6.13 and 2.6.14?

Ray
