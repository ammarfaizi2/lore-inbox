Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbUKVKAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbUKVKAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbUKVKAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:00:38 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:61847 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262010AbUKVKAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:00:21 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 22 Nov 2004 10:43:12 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: var args in kernel?
Message-ID: <20041122094312.GC29305@bytesex>
References: <20041109074909.3f287966.akpm@osdl.org> <1100018489.7011.4.camel@lb.loomes.de> <20041109211107.GB5892@stusta.de> <1100037358.1519.6.camel@lb.loomes.de> <20041110082407.GA23090@bytesex> <1100085569.1591.6.camel@lb.loomes.de> <20041118165853.GA22216@bytesex> <419E689A.5000704@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419E689A.5000704@backtobasicsmgmt.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 02:41:46PM -0700, Kevin P. Fleming wrote:
> Gerd Knorr wrote:
> >Yet another kobject bug.  It uses the varargs list twice in a illegal
> >way.  That doesn't harm on i386 by pure luck, but blows things up on
> >amd64 machines.  The patch below fixes it.
> 
> Is this safe? The normal glibc varargs implementation says you can't 
> even call va_start on the same args list twice, you have to use va_copy 
> to make a clone and then call va_start on that, _before_ you ever call 
> va_start the first time.

Hmm, maybe.  I'm not sure who actually implements the varargs (gcc?
Or glibc/kernel?) and whenever the above applies to the kernel as well
or not ...

Cc'ing the kernel list for comments.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
