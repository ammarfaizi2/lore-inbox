Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWG0OYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWG0OYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWG0OYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:24:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:2501 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751344AbWG0OYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:24:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A5IpYHwJK8C5O8ocXsBtmlNCOt4CVpVc68VIDiv8bKeGvEIUIsOG8qxUOEnwW43kxCHtB4RHBAWwCJEjVMBm8aGKzFGVhBDq5snYc7eUjEGouO1LOZ8mkeAeCITshs3kAs+vuodzKAPus/7Co1E0vbND81u5PNY/pJHp3AahXKM=
Message-ID: <f96157c40607270724n72234492n9a34accca6512e91@mail.gmail.com>
Date: Thu, 27 Jul 2006 14:24:20 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>
Subject: Re: [WARNING -mm] 2.6.18-rc2-mm1 build kills /dev/null!?
Cc: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <44C8CB5F.5040705@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060727101128.GA31920@rhlx01.fht-esslingen.de>
	 <44C8CB5F.5040705@tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Andreas Mohr wrote:
> > Hello all,
> >
> > for some reason a 2.6.18-rc2-mm1 build seems to kill my /dev/null device!
> >
> > A simple
> > # make bzImage modules modules_install
> > managed to reduce my
> >
> > crw-rw-rw-    1 root     root       1,   3 27. Jul 12:04 null
> >
> > into the charred remains equivalent of
> >
> > -rw-r--r--    1 root     root            0 27. Jul 12:02 null
>
> Don't build as root.
>
> While something's broke in kernel build scripts and probably
> should be fixed, it's not a reason for anyone to get their
> whole filesystem rm -rf'ed.

and it does not matter if you're using udev:
$ ls -l /dev/null
crw-rw-rw- 1 root root 1, 3 2006-07-27 11:42 /dev/null
