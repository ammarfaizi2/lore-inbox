Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVCNT6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVCNT6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVCNT57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:57:59 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:19954 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261779AbVCNT55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:57:57 -0500
Subject: Re: 2.6.11-bk10 build problems
From: Dave Hansen <haveblue@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kai@germaschewski.name
In-Reply-To: <20050314194930.GB17373@mars.ravnborg.org>
References: <1110829177.19340.8.camel@localhost>
	 <20050314194930.GB17373@mars.ravnborg.org>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 11:57:39 -0800
Message-Id: <1110830259.19340.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 20:49 +0100, Sam Ravnborg wrote:
> On popular request 'make install' no longer try to update vmlinux.
> This is to avoid errornous recompilation when installing the kernel
> as root especially when fetching kernel via nfs where path may have
> changed.

That makes sense, but it's still quite a surprise, and a serious change
in behavior from as long as I've been compiling kernels.

How about a new "make install-norebuild" or something that doesn't
change current, relied-upon behavior?  Seems like the weirdos^Wusers
doing kernel fetches over nfs are probably the minority, and their small
numbers can be much more easily educated than the masses who expect
'make menuconfig; make install' to do what it's always done.  

If that's too invasive, how about restoring the old behavior with a
warning to stderr for a release or two?

-- Dave

