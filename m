Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbTHTWqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTHTWqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:46:42 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:33154 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262304AbTHTWql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:46:41 -0400
Date: Wed, 20 Aug 2003 23:46:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Sergey Spiridonov <spiridonov@gamic.com>, linux-kernel@vger.kernel.org
Subject: Re: how to turn off, or to clear read cache?
Message-ID: <20030820224628.GA24639@mail.jlokier.co.uk>
References: <3F4360F0.209@gamic.com> <200308201311.h7KDBgL20530@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308201311.h7KDBgL20530@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On 20 August 2003 14:52, Sergey Spiridonov wrote:
> > I need to make some performance tests. I need to switch off or to clear 
> > read cache, so that consequent reading of the same file will take the 
> > same amount of time.
> 
> umount/mount cycle will do it, as well as intentional OOMing the box
> (from non-root account please;)

umount/mount is impractical when you're testing performance on a big
filesystem, which is always being used (e.g. /home).

I'm fairly sure that -o remount used to have this side effect, in fact
I used it quite a lot for that purpose, so it should be possible to
make it work again, or add a -o flushcache option.

-- Jamie

