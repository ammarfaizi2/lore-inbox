Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVAYJiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVAYJiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 04:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVAYJiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 04:38:12 -0500
Received: from mxc.rambler.ru ([81.19.66.31]:23058 "EHLO mxc.rambler.ru")
	by vger.kernel.org with ESMTP id S261795AbVAYJiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 04:38:08 -0500
Date: Tue, 25 Jan 2005 12:35:16 +0300
From: Pavel Fedin <sonic_amiga@rambler.ru>
To: Alex Riesen <raa.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Russian encoding support for MacHFS
Message-Id: <20050125123516.7f40a397.sonic_amiga@rambler.ru>
In-Reply-To: <81b0412b05012410463c7fd842@mail.gmail.com>
References: <20050124125756.60c5ae01.sonic_amiga@rambler.ru>
	<81b0412b05012410463c7fd842@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0beta2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Auth-User: sonic_amiga, whoson: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 19:46:18 +0100
Alex Riesen <raa.lkml@gmail.com> wrote:

> how about just leave the characters unchanged? (remap them to the same
> codes in Unicode).

 But what to do when i convert then from unicode to 8-bit iocharset? This can lead to that several characters in Mac charset will be converted to the same character in Linux charset. This will lead to information loss and name will not be reverse-translatable.
 To describe the thing better: i have 8-bit Mac encoding and 8-bit target encoding (iocharset). I need to convert from (1) to (2) and be able to convert back. I tried to perform a one-way conversion like in other filesystems but this didn't work.
 Probably NLS tables can be used when iocharset is UTF8. If you wish i can try to implement it after some time.

> Unicode, and its encoding UTF8 IS commonly used everywhere.
> And Russia can (and often does) use it just as well.

 Many people say many software is not UTF8-ready yet. Anyway i had problems when tried to use it. Many russian ASCII documents use 8-bit encoding so i need to be able to deal with them. Many software assumes that 1 byte is 1 character.

> P.S. Read Documentation/SubmittingPatches.

 Ok. Sorry for violations.

> What kernel is the patch against?

 2.6.8.

-- 
Best regards,
Pavel Fedin,									mailto:sonic_amiga@rambler.ru
