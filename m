Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbUKAGhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUKAGhs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 01:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUKAGhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 01:37:48 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:42449 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261401AbUKAGhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 01:37:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bNUGWIH8hyQzhxb+LUx7Gc5Y8KvCT40genLbR+qsREENfSQqrVjWy8++PhmOwA2hu35wTpyHQiMkbGRjjk584/b1Ddw4ZigyN3YgC5J45KMQfHfKEsUJEwvUW9ASP0u1pY60hYSK4zFqJwm4X7xEywHxrSPlwp+++S1GaZDzLSQ=
Message-ID: <9e473391041031223761ffbf7f@mail.gmail.com>
Date: Mon, 1 Nov 2004 01:37:42 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
Cc: Christoph Hellwig <hch@infradead.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1099288890.25525.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e473391041022214570eab48a@mail.gmail.com>
	 <20041023095644.GC30137@infradead.org>
	 <9e47339104102311229276d8@mail.gmail.com>
	 <1099288890.25525.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did notice that patch from a while ago. 

The code in DRM CVS works and it has no DRM() macros, inter_module_xx
is gone, and it splits DRM in to DRM-core plus personality modules.
Now all we have to do is get it merged into the kernel.  The diffs are
huge due to lindent reformatting and removal of DRM() macros.

cvs -z3 -d:pserver:anonymous@dri.freedesktop.org:/cvs/dri co drm
make in linux-core

I'm still working on the merged fbdev/DRM but it doesn't work right
yet. Making fbdev understand multiple heads is causing considerable
changes to fbdev since the fb_info structure does not separate per
head variables from per card ones. I don't have the split sorted out
yet.

The code is based off from DRM CVS. bk://mesa3d@bkbits.net/drm-fb
make in linux-fb

-- 
Jon Smirl
jonsmirl@gmail.com
