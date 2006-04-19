Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWDST3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWDST3Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWDST3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:29:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60587 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751017AbWDST3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:29:24 -0400
Date: Wed, 19 Apr 2006 12:28:03 -0700
From: Greg KH <greg@kroah.com>
To: David Wilk <davidwilk@gmail.com>, hugh@veritas.com
Cc: stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
Message-ID: <20060419192803.GA19852@kroah.com>
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 12:52:33PM -0600, David Wilk wrote:
> Howdy folks.  thanks for the great work on the stable series, btw.
> 
> I think an issue was introduced with mprotect (the first patch in
> 2.6.16.6).  With 2.6.16.5, tomcat runs fine (in sun-1.5), but in
> 2.6.16.7, the JVM bails out complaining that it couldn't allocate
> enough heap space.
> 
> If I remove '-Xmx768m' from JAVA_OPTS, then the JVM is able to
> startup.  The machine had 1GB of RAM and 2GB of swap, so it should
> have had plenty to give the JVM the 1GB it expects to get with an Xmx
> of 768MB, and this worked in 2.6.16.5 and below.
> 
> I don't know if this is expected and satisfactory behavior, but I
> figured I should give ya'll the heads up.

Odds are it isn't "expected", but Hugh would be the best judge of that.
Hugh?

thanks for letting us know about this,

greg k-h
