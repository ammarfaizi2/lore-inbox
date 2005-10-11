Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVJKUVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVJKUVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVJKUVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:21:04 -0400
Received: from mail.suse.de ([195.135.220.2]:57560 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751161AbVJKUVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:21:02 -0400
From: Andi Kleen <ak@suse.de>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
Date: Tue, 11 Oct 2005 22:21:05 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Georg Lippold <georg.lippold@gmx.de>
References: <431628D5.1040709@zytor.com> <p73br1vsvup.fsf@verdi.suse.de> <434C1189.4090207@gmail.com>
In-Reply-To: <434C1189.4090207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510112221.05789.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 October 2005 21:24, Alon Bar-Lev wrote:

> I don't understand this dependency. The cmd_line_ptr is a
> null terminated string which set by the boot loader.

Yes and limited by it and the boot protocol. And changing that CONFIG
wont' change that. IMHO this config is highly misleading.

> I think that the maximum size should be set to 1024, but
> since the kernel allocates a static buffer, users may wish
> to optimize it. So I think that a configuration option is
> the right place.

It's a bad idea to have a CONFIG for every buffer. If we go down this way
this way we end up with a unconfigurable kernel at some point with
hundreds of obscure parameters. Just increase it if there is a need for it.
If you're really worried about memory consumption you can
make the big buffer __initdata and copy it to a newly allocated buffer of the 
right size.

-Andi
