Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTEHRO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 13:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTEHRO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 13:14:29 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:37536 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261879AbTEHRO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 13:14:27 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Jamie Lokier <jamie@shareable.org>
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
References: <20030506164252.GA5125@mail.jlokier.co.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 08 May 2003 13:11:00 +0200
In-Reply-To: <20030506164252.GA5125@mail.jlokier.co.uk>
Message-ID: <m3llxhlmm3.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> I was mulling over a commercial project proposal, and this question
> came up:
> 
> What's the position of kernel developers towards using the GPL'd Linux
> kernel modules - that is, device drivers, network stack, filesystems
> etc. - with a binary-only, closed source kernel that is written
> independently of Linux?

IANAL, but Linux drivers are usually licensed under the GPL and not LGPL.
> 
> I realise that linking the modules directly with the binary kernel is
> a big no no, but what if they are dynamically loaded?

You mean one big file versus many small fragments? I don't think there
is a difference. LGPL would permit that (in fact, it seems to be the
difference between GPL and LGPL).

> There seems to be a broad agreement, and I realise it isn't unanimous,
> that dynamically loading binary-only modules into the Linux kernel is
> ok.

That's different, the modules are not (generally) derivatives of the
kernel. The (running) kernel is a derivative of both the GPL code and
binary drivers (all parts are linked at run time) - and while you can't
distribute such a beast at all, you usually don't want to.
(which makes me wonder if "distributing" a running machine with binary
drivers linked to the kernel is legal :-) )

>  Furthermore, there are some funny rules about which interfaces a
> binary-only module may use and which it may not, before it's
> considered a derivative work of the kernel.

IMHO it's independent problem, not related to the license, but rather
to source code symbol names (a technical and not legal issue - something
like copy-protection mechanisms).

> So, as dynamic loading is ok between parts of Linux and binary-only
> code, that seems to imply we could build a totally different kind of
> binary-only kernel which was able to make use of all the Linux kernel
> modules.

Build - sure. However, distributing such a system (with GPLed parts)
would be illegal, unless the GPLed code is not a part of the system,
and rather an "independent and separate work" (i.e. the system does not
"depend" on GPL part).
-- 
Krzysztof Halasa
Network Administrator
