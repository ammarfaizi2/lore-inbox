Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVHRKGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVHRKGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 06:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVHRKGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 06:06:06 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:63401 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932161AbVHRKGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 06:06:05 -0400
Date: Thu, 18 Aug 2005 12:05:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zero-copy read() interface
Message-ID: <20050818100536.GB16751@wohnheim.fh-wedel.de>
References: <20050818100151.GF12313@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050818100151.GF12313@vanheusden.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 August 2005 12:01:52 +0200, Folkert van Heusden wrote:
> 
> What about a zero-copy read-interface?
> An ioctl (or something) which enables the kernel to do dma directly to
> the userspace. Of course this should be limited to the root-user or a
> user with special capabilities (rights) since if a drive screws up, data
> from a different sector (or so) might end up in the proces' memory. Of
> course copying a sector from kernel- to userspace can be done pretty
> fast but i.m.h.o. all possible speedimprovements should be made unless
> unclean.

Just use mmap().  Unlike your proposal, it cooperates with the page
cache.

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979
