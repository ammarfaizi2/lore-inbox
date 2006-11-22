Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162012AbWKVJLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162012AbWKVJLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 04:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162011AbWKVJLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 04:11:13 -0500
Received: from gw.goop.org ([64.81.55.164]:3472 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1162012AbWKVJLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 04:11:11 -0500
Message-ID: <45641422.5090601@goop.org>
Date: Wed, 22 Nov 2006 01:10:58 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
       kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
References: <4563667B.2060209@goop.org> <4563F158.3060209@qumranet.com>
In-Reply-To: <4563F158.3060209@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Very interesting.
>
> Will it work on load/store architectures?  Since all memory access is
> through a register, won't the constraint generate a useless register
> load (and a use of the variable)?

Don't know; interesting question.  It might be worth lobbying the gcc
folks for an asm() constraint which means "pretend this is being
read/written, but don't generate any code, and raise an error if the asm
actually tries to use it".  Or perhaps there's some way to do that already.

On the other hand, load/store archs tend to have lots of registers
anyway, so maybe it isn't a big deal.

    J


