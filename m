Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbTDWPxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbTDWPxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:53:52 -0400
Received: from host-62-245-209-32.customer.m-online.net ([62.245.209.32]:60051
	"EHLO frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S264105AbTDWPxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:53:50 -0400
Date: Wed, 23 Apr 2003 18:05:56 +0200
To: Werner Almesberger <wa@almesberger.net>
Cc: Robert Love <rml@tech9.net>, Julien Oster <frodo@dereference.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel ring buffer accessible by users
Message-ID: <20030423160556.GA30306@frodo.midearth.frodoid.org>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org> <1051031876.707.804.camel@localhost> <20030423125602.B1425@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423125602.B1425@almesberger.net>
User-Agent: Mutt/1.4i
From: frodoid@frodoid.org (Julien Oster)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 12:56:03PM -0300, Werner Almesberger wrote:

Hello Werner,

> > I think the problem is that kernel messages should not contain private
> > information, like ISDN phone numbers.  Why is that even in the kernel?

> How do you know what is sensitive information ? A kernel debug
> message may just say something like "bad message 47 65 68 65 69 6d",
> and the kernel has no idea that this is actually a password
> ("Geheim").

Exactly what I mean, thanks for pointing this out!

I'm afraid I can't remember a specific example, but I remember that
there actually happened something like that and those were things where
the kernel simply couldn't know that the info it gave was "secret".

Of course one could say "then let's just stop writing out anything in
the kernel buffer that COULD be sensitive", but I think this would
actually castrate the meaning of such a buffer.

Why exactly should an ordinary user have access to the kernel ring
buffer? I can't imagine anything that could be of any interest for him
or her. And there's stillt he possibility to tweak the permissions for
dmesg so that only a certain group (staff, operator, adm...) can execute
it, but then setuid root. That way, operators being non-root are also
happy.

Just because Solaris allows access, Linux doesn't have to, or has it?
And I think that in all those years the kernel output from Linux has
been growing immensly compared to that of Solaris.

Regards,
Julien

