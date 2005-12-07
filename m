Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVLGA5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVLGA5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 19:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLGA5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 19:57:12 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:675 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S964852AbVLGA5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 19:57:12 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Grover <andy.grover@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian Gerst <bgerst@didntduck.org>,
       Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <c0a09e5c0512061525n1c1a472ci56eeef22a6d970b4@mail.gmail.com>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>
	 <20051206030828.GA823@opteron.random> <4394696B.6060008@didntduck.org>
	 <1133894575.4136.171.camel@baythorne.infradead.org>
	 <1133897035.23610.32.camel@localhost.localdomain>
	 <1133907922.4136.218.camel@baythorne.infradead.org>
	 <c0a09e5c0512061525n1c1a472ci56eeef22a6d970b4@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 00:56:54 +0000
Message-Id: <1133917014.4136.244.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 15:25 -0800, Andrew Grover wrote:
> Where possible ACPI does still use tables. For more complicated
> configuration, ACPI uses easily-decompiled bytecodes. I think if the
> graphics bios provided arch-neutral AML for doing all this
> mode-setting stuff we'd be better off. Better than interpreting x86
> real-mode BIOS code!

This is true. Real drivers with only _tables_ to describe the hardware
would be best, but AML would be at least be better than i386 code, if we
have to settle for something less.

> You have to get a priori information about the system somewhere. With
> ACPI at least it's not a complete mystery what the BIOS is doing,
> unlike these video BIOSes.

Actually, the one time I tried to decompile a DSDT it was a Dell
Inspiron which did _everything_ through SMM traps. It was more opaque
even than a binary-only driver (or BIOS). At least with i386-code I have
_some_ hope of tracing it, if I have enough time and patience.

-- 
dwmw2


