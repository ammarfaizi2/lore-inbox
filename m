Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbTHTWwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbTHTWwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:52:10 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:17162
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262293AbTHTWwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:52:06 -0400
Date: Wed, 20 Aug 2003 15:52:00 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Sergey Spiridonov <spiridonov@gamic.com>, linux-kernel@vger.kernel.org
Subject: Re: how to turn off, or to clear read cache?
Message-ID: <20030820225200.GB1040@matchmail.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Sergey Spiridonov <spiridonov@gamic.com>,
	linux-kernel@vger.kernel.org
References: <3F4360F0.209@gamic.com> <200308201311.h7KDBgL20530@Port.imtp.ilyichevsk.odessa.ua> <20030820224628.GA24639@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030820224628.GA24639@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 11:46:28PM +0100, Jamie Lokier wrote:
> Denis Vlasenko wrote:
> > On 20 August 2003 14:52, Sergey Spiridonov wrote:
> > > I need to make some performance tests. I need to switch off or to clear 
> > > read cache, so that consequent reading of the same file will take the 
> > > same amount of time.
> > 
> > umount/mount cycle will do it, as well as intentional OOMing the box
> > (from non-root account please;)
> 
> umount/mount is impractical when you're testing performance on a big
> filesystem, which is always being used (e.g. /home).
> 
> I'm fairly sure that -o remount used to have this side effect, in fact
> I used it quite a lot for that purpose, so it should be possible to
> make it work again, or add a -o flushcache option.

Won't that hold a lot of locks, and possibly pause the system until the
flushing is complete?  Hopefully, in 2.6 this doesn't call lock_kernel...
