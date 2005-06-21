Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVFUP6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVFUP6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVFUP6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:58:02 -0400
Received: from mail.dvmed.net ([216.237.124.58]:59047 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262128AbVFUP4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:56:51 -0400
Message-ID: <42B838BC.8090601@pobox.com>
Date: Tue, 21 Jun 2005 11:56:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
References: <Pine.LNX.4.58.0506211304320.2915@skynet> <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I guess I can make the "git pull" script do that automatically (some other
> scripts do, like "git commit", which also depends on having an up-to-date
> index).

Slight tangent...  it would be nice if you would write a 2-line 
git-checkout-script, which provides the modern version of

	git-read-tree -m HEAD && git-checkout-cache -q -f -u -a

Note that I do depend on this command blowing away working dir changes, 
but maybe you would want that to be a separate arg.

Then you could add a "-u" arg, or somesuch, to the situations like git 
pull that want an up-to-date index.

	Jeff


