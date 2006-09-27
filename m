Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031160AbWI0Wel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031160AbWI0Wel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031161AbWI0Wel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:34:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63132 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1031160AbWI0Wej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:34:39 -0400
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
From: Arjan van de Ven <arjan@infradead.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
In-Reply-To: <45198395.4050008@aknet.ru>
References: <45150CD7.4010708@aknet.ru>
	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
	 <451555CB.5010006@aknet.ru>
	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
	 <1159037913.24572.62.camel@localhost.localdomain>
	 <45162BE5.2020100@aknet.ru>
	 <1159106032.11049.12.camel@localhost.localdomain>
	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>
	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>
	 <45198395.4050008@aknet.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 28 Sep 2006 00:33:50 +0200
Message-Id: <1159396436.3086.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 23:46 +0400, Stas Sergeev wrote:
> Hi Guys.
> 
> Noone provided a reason for (or even tried to defend)
> the fact that PROT_EXEC is rejected by "noexec" even
> for MAP_PRIVATE, while, say, PROT_WRITE is *not* rejected
> for "ro" filesystem for MAP_PRIVATE. What was argued is
> only MAP_SHARED.

is it?

> - The programs (like AFAIK wine) use MAP_PRIVATE mmaps to
> access the windows dlls, which are usually on a "noexec"
> fat or ntfs partitions. Wine might be smart enough not to
> break but fallback to read(), but this is slower and more
> memory-consuming. Some other program may not be that smart
> and break. So there is clearly a need for MAP_PRIVATE with
> PROT_EXEC on the noexec partitions.

but really again you are degrading what noexec means.
It now starts to mean "only don't execute a little bit" rather than
"deny execute requests"....


