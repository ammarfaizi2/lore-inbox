Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbVKVUrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVKVUrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 15:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVKVUrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 15:47:51 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:12475 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965179AbVKVUru convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 15:47:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RAsyiRGr9gxjs47KCF3H3BhxwWeeI3iWsc5Orig3uXGtoNRi1nOe/xAe0h12sz+8Fu5sVYIAMZB4sJAg1cv1g6efW0bcUkHGV7MGwlL/d7sbHjOzeY59zmGfGKgzUbO1u0meo6DGTuz+dXrp+CC1Cluc9UZr2KvG70MR35hGrfY=
Message-ID: <cbec11ac0511221247k7b72eb4bmbcaa8c522bd8c005@mail.gmail.com>
Date: Wed, 23 Nov 2005 09:47:49 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.15-rc1-mm1
Cc: Ed Tomlinson <tomlins@cam.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051121002623.GA11271@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117111807.6d4b0535.akpm@osdl.org>
	 <200511182024.33858.tomlins@cam.org>
	 <20051119012632.GA28458@kroah.com>
	 <200511182224.10392.tomlins@cam.org>
	 <20051121002623.GA11271@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or a broken userspace configuration that just happened to work
> previously :)
>
> I really don't know which one this is, but as it seems it only is
> showing up on Debian systems...
>
> thanks,
>
> greg k-h
>
OK. Have got quite a bit further in tracking this down and will now
log with Debian somehow.

It is definitely userspace but I don't know enough about that to say
whether it is udev (Debian rules) or something else.

I used git-bisect with 2.6.14 and 2.6.15-rc1 as start and end points.
In the end the patch which caused it to break was the final one - just
altering the Makefile with the version number. I've reverified as well
by going back to 2.6.15-rc1 and just altering it to 2.6.14 and the
problem (mousedev not loaded automatically and no /dev/input /mice)
disappears. I almost thought I'd made a mistake in my testing until I
manually altered that makefile!!

It is definitely not a kernel issue in my opinion.

Ian
--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
