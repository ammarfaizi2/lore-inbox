Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWBVCSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWBVCSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWBVCSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:18:05 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39108 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932544AbWBVCSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:18:04 -0500
Message-ID: <43FBC9BF.2020407@zytor.com>
Date: Tue, 21 Feb 2006 18:17:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Bailey <jbailey@ubuntu.com>
CC: Michael Neuling <mikey@neuling.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       klibc@zytor.com, "miltonm@bga.com" <miltonm@bga.com>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [klibc] [PATCH] initramfs: multiple CPIO unpacking fix
References: <20060216183745.50cc2bf6.mikey@neuling.org> <20060217160621.99b0ffd4.mikey@neuling.org> <20060222104525.affda1df.mikey@neuling.org> <1140574441.5304.37.camel@localhost.localdomain>
In-Reply-To: <1140574441.5304.37.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Bailey wrote:
> 
> I've tended to think of this as a feature, actually.  In Ubuntu, for
> instance, we might have 2.6.15-8 and 2.6.15-9 which represent different
> ABIs from security updates or other changes.  If I have a module that is
> intended to be compatible with both, I might setup /lib/modules/generic
> to be a symlink to /lib/modules/2.6.15-9/ and unpack the modules after
> the symlink is expected to be there.
> 

This is pretty broken for a bunch of other reasons, though.  In 
particular, it prevents the very useful behaviour of providing a symlink 
in entry A that can be overridden by a file in entry B.

> (I don't think we use this feature right now, but I had tested it and
> noted it before.  It's very convenient, since it's the exact same
> behaviour that dpkg itself has)

I would personally consider that a bug in dpkg :-/

	-hpa
