Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUGLP64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUGLP64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUGLP64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:58:56 -0400
Received: from mail.enyo.de ([212.9.189.167]:20241 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S266850AbUGLP6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:58:46 -0400
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <20040707122525.X1924@build.pdx.osdl.net>
	<Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>
	<Pine.LNX.4.58.0407091313570.20635@scrub.home>
	<Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be>
	<ccs6j2$b8a$1@terminus.zytor.com>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Mon, 12 Jul 2004 17:58:43 +0200
In-Reply-To: <ccs6j2$b8a$1@terminus.zytor.com> (H. Peter Anvin's message of
 "Sun, 11 Jul 2004 20:05:54 +0000 (UTC)")
Message-ID: <87r7rhb4jw.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Peter Anvin:

> Followup to:  <Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be>
> By author:    Geert Uytterhoeven <geert@linux-m68k.org>
> In newsgroup: linux.dev.kernel
>> 
>>   - `return f();' in a function returning void (where f() returns void as well)
>> 
>
> Considering this one a bug is daft in the extreme.
>
> Why?  Because "return f();" is the only kind of tailcall syntax C has,

Huh?  If you remove the "return", it's still a valid tailcall syntax
(at least from GCC's perspective).
