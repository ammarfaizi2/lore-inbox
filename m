Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbUKKUo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUKKUo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 15:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUKKUnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 15:43:08 -0500
Received: from mx1.elte.hu ([157.181.1.137]:35002 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262356AbUKKUmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 15:42:49 -0500
Date: Thu, 11 Nov 2004 22:44:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 4/4GB: remove FIXADDR_TOP changing
Message-ID: <20041111214453.GB5643@elte.hu>
References: <419390CC.9040805@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419390CC.9040805@sw.ru>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill Korotaev <dev@sw.ru> wrote:

> This patch fixes VSYSCALL_BASE/FIXADDR_TOP relations problems
> in 4gb split kernels (under some combinations of options/patches):
> - if FIXADDR_TOP is changed, VSYSCALL_BASE in vsyscall.lds should be
>   changed as well
> - original 4gb split changes FIXADDR_TOP to be sure that stack
>   is 2 pages aligned, but vsyscall.lds uses hardcoded constants inside.
>   So we had /sbin/init loading problems due to ld-linux.so trying to
>   access wrong addresses in VSYSCALL page.
> 
> The fix is the aligment of 4gb pages instead of alignment of
> FIXADDR_TOP

indeed - thanks!

	Ingo
