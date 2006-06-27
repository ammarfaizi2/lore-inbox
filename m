Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161244AbWF0R7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbWF0R7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbWF0R7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:59:13 -0400
Received: from terminus.zytor.com ([192.83.249.54]:26603 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161244AbWF0R7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:59:11 -0400
Message-ID: <44A171DF.80206@zytor.com>
Date: Tue, 27 Jun 2006 10:58:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: KBUILD tries to make initramfs contents :-)
References: <m3wtb27noz.fsf@defiant.localdomain> <20060627175032.GB26435@mars.ravnborg.org>
In-Reply-To: <20060627175032.GB26435@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
>
> Should it stay this way or is it a bug?
> Oh Crap. It's a bug. The intent it to rebuild initramfs when content of
> the initramfs changes.
> But not to rebuild content of initramfs of course.
> 

No, it's worse than that.

The intent very much IS to rebuilt the content of initramfs, when it's 
included in the tree.

> No solution right now - will take a look during the weekend.

I guess the dependency-generation machinery will need to distinguish 
between in-tree and out-of-tree files.  It should be relatively easy, 
since out-of-tree files will have paths that begin with "/" or "../".

	-hpa

