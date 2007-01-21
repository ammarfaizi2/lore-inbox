Return-Path: <linux-kernel-owner+w=401wt.eu-S1751169AbXAUCQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbXAUCQK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 21:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbXAUCQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 21:16:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60776 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbXAUCQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 21:16:08 -0500
Subject: Re: [PATCH] Undo some of the pseudo-security madness
From: Arjan van de Ven <arjan@infradead.org>
To: Samium Gromoff <_deepfire@feelingofgreen.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87y7nxvk65.wl@betelheise.deep.net>
References: <87y7nxvk65.wl@betelheise.deep.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 21 Jan 2007 03:16:04 +0100
Message-Id: <1169345764.3055.935.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-20 at 17:37 +0300, Samium Gromoff wrote:
> This patch removes the dropping of ADDR_NO_RANDOMIZE upon execution of setuid
> binaries.
> 
> Why? The answer consists of two parts:
> 
> Firstly, there are valid applications which need an unadulterated memory map.
> Some of those which do their memory management, like lisp systems (like SBCL).
> They try to achieve this by setting ADDR_NO_RANDOMIZE and reexecuting themselves.

this is a ... funny way of achieving this

if an application for some reason wants some fixed address for a piece
of memory there are other ways to do that.... (but to some degree all
apps that can't take randomization broken; for example a glibc upgrade
on a system will also move the address space around by virtue of being
bigger or smaller etc etc)


> [1]. See the excellent, 'Hackers Hut' by Andries Brouwer, which describes
> how AS randomisation can be got around by the means of linux-gate.so.1

got a URL to this? If this is exploiting the fact that the vdso is at a
fixed spot... it's no longer the case since quite a while.


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

