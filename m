Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752118AbWIHEQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbWIHEQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 00:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbWIHEQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 00:16:38 -0400
Received: from nef2.ens.fr ([129.199.96.40]:32772 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1752118AbWIHEQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 00:16:37 -0400
Date: Fri, 8 Sep 2006 06:16:32 +0200
From: David Madore <david.madore@ens.fr>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908041632.GC24135@clipper.ens.fr>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906182531.GA24670@sergelap.austin.ibm.com> <20060906222731.GA10675@clipper.ens.fr> <20060907000441.GA22240@clipper.ens.fr> <20060907230630.GA15538@sergelap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907230630.GA15538@sergelap>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 08 Sep 2006 06:16:33 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 06:06:30PM -0500, Serge E. Hallyn wrote:
> I'm not sure reserving all 32 for 'regular' caps is the way
> to go, since we're about to overflow the 32 bits of sysadm caps
> already.  What about maybe 20 regular caps?

Yes, that could easily be arranged.  I've tried to be careful and
nowhere asssume that the regular caps were precisely numbers 32
through 63.

> No need to do this now for my sake, but if you repost these, doing so
> in 3 separate emails with the patches inline will make it more likely
> that people read them.

I'll do this now for version 0.4.2, which merges with your own
filesystem support.  I made one noteworthy change to your code, by the
way, which is to disable the "permitted" (=forced) set of capabilities
on executables whose filesystem is mounted nosuid: I think this is a
reasonable constraint, to avoid the attack where a luser mounts a usb
key with xattrs in the filesystem or something like that.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
