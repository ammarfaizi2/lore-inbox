Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVISHY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVISHY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVISHY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:24:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3273 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932354AbVISHY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:24:58 -0400
Date: Mon, 19 Sep 2005 09:24:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin =?iso-8859-1?Q?v=2E_L=F6wis?= <martin@v.loewis.de>
Cc: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
Message-ID: <20050919072446.GF1893@elf.ucw.cz>
References: <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de> <20050917120123.GA3095@ucw.cz> <432C0B51.704@v.loewis.de> <20050919070820.GA2382@elf.ucw.cz> <432E6649.1070408@v.loewis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <432E6649.1070408@v.loewis.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 19-09-05 09:18:33, "Martin v. Löwis" wrote:
> Pavel Machek wrote:
> > Why is binfmt_misc not enough for you?
> 
> For two reasons: for one, it has the overhead of yet another
> exec call. This is different from usages for, say, Java byte
> code or Python byte code, where the registered interpreter already
> is the eventual binary which has to be invoked anyway; for
> a binfmt_misc application, you need an additional wrapper
> which reinterprets the first line, and then invokes the eventual
> interpreter.

Who cares? exec is fast.

> The other reason is availability: as an author of an UTF-8
> script, you would have to communicate to your users that they
> need the right binfmt_misc wrapper installed (which they may
> have to build first). While installing additional stuff to
> run a single program is acceptable for large applications,
> it is likely not for script files. To make the feature useful
> in practice, it must be builtin.

This is distribution problem, not kernel problem. "/bin/ls should be
built into kernel, because otherwise you can't call /bin/ls from
script" is not an argument.

If UTF-8 compatibility is important, distros will get it right. If it
is not, you loose, but at least kernel is not messed up.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
