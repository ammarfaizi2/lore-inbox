Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270859AbTGVRM3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270861AbTGVRM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:12:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:11392 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270859AbTGVRM2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:12:28 -0400
Date: Tue, 22 Jul 2003 18:27:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: asm (lidt) question
Message-ID: <20030722172722.GC3267@mail.jlokier.co.uk>
References: <20030717152819.66cfdbaf.rddunlap@osdl.org> <Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com> <Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> IMHO, since "var" is really an output parameter.

"var" is read, not written.
I think you are confusing "lidt" with "sidt".

Therefore

> __asm__ __volatile__("lidt %0": :"m" (var));

is the better choice, and that's why I wrote it in reboot.c :)

-- Jamie
