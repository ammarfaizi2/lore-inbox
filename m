Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTE2T5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 15:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbTE2T5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 15:57:16 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:22410 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262584AbTE2T5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 15:57:15 -0400
Date: Thu, 29 May 2003 22:10:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, ak@suse.de, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-ID: <20030529201010.GF1454@elf.ucw.cz>
References: <p73wuga6rin.fsf@oldwotan.suse.de> <20030529.023203.41634240.davem@redhat.com> <20030529112517.GC1215@elf.ucw.cz> <20030529.042615.55727031.davem@redhat.com> <1054208379.5223.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054208379.5223.0.camel@laptop.fenrus.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >    What is copy_in_user?
> > 
> > Both source and destination pointers are in userspace.
> 
> sys_memcpy() ?

No, its for in-kernel usage. If you want to copy 10 bytes in
userspace, you can't use memcpy()... You'd have to do copy_from_user()
then copy_to_user(); and that's what copy_in_user does.

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
