Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbTLRWDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 17:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbTLRWDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 17:03:11 -0500
Received: from mail01.hansenet.de ([213.191.73.61]:3000 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S265336AbTLRWDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 17:03:09 -0500
From: Thomas Koeller <thomas@koeller.dyndns.org>
To: Greg KH <greg@kroah.com>
Subject: Re: module use count & unloading
Date: Thu, 18 Dec 2003 23:03:04 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031218150525.5504D12001E@sarkovy.koeller.dyndns.org> <20031218163756.GA20882@kroah.com>
In-Reply-To: <20031218163756.GA20882@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312182303.05024.thomas@koeller.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 December 2003 17:37, Greg KH wrote:
>
> It wasn't safe to do that in 2.4 either.  That would easily unload your
> USB controller drivers, USB keyboard and USB mouse drivers, as they all
> do not increment their in-use count.

Thanks for your reply. I am, however, somewhat confused now. If the
in-use count cannot be trusted, then unloading a module is a fundamentally
unsafe operation, and a tool like 'rmmod' should not exist at all. I also
remember that in 2.4 periodic unloading of all unused autoloaded modules
by a cron job used to work just fine. And finally, if module unloading is
inherently unsafe, what is the significance of all this stuff about
forced module unloading and its dangers?

I assumed this was a bug at first and reported it as one, because I could
not make much sense of it. Now that I've been told that this kind of
behavior is actually intended, I still cannot...

tk
-- 
Thomas Koeller
thomas at koeller dot dyndns dot org

