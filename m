Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWFKVEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWFKVEG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 17:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWFKVEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 17:04:06 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:43723 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1750974AbWFKVEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 17:04:04 -0400
Message-ID: <448C85B7.1010902@labri.fr>
Date: Sun, 11 Jun 2006 23:05:59 +0200
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: use C code for current_thread_info()
References: <200606111647_MC3-1-C228-993B@compuserve.com>
In-Reply-To: <200606111647_MC3-1-C228-993B@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> 
> I just tried gcc 3.3.3 and the kernel gets a little bigger but it boots
> and runs OK. That's the oldest compiler I can find.
> 
>    text    data     bss     dec     hex filename
> 3593627  559864  342728 4496219  449b5b 2.6.17-rc6-32-post/vmlinux
> 3591371  559864  342728 4493963  44928b 2.6.17-rc6-32/vmlinux
>   +2256
> 
> Looking at the generated code, it seems the compiler just makes dumb
> choices and tends to recompute current_thread_info() in unlikely code
> paths even when there is no register pressure.  4.0.2 makes better
> choices.

What size with gcc 4.1.2 ? (just curiosity)

Regards
-- 
Emmanuel Fleury              | Office: 211
Associate Professor,         | Phone: +33 (0)5 40 00 35 24
LaBRI, Domaine Universitaire | Fax:   +33 (0)5 40 00 66 69
351, Cours de la Libération  | email: fleury@labri.fr
33405 Talence Cedex, France  | URL: http://www.labri.fr/~fleury
