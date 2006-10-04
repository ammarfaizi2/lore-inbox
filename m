Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWJDTep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWJDTep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWJDTep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:34:45 -0400
Received: from mail.aknet.ru ([82.179.72.26]:55054 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750905AbWJDTeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:34:44 -0400
Message-ID: <45240D4E.7090500@aknet.ru>
Date: Wed, 04 Oct 2006 23:36:46 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>	 <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru> <45229C8E.6080503@redhat.com>	 <4522A691.7070700@aknet.ru> <4522B7CD.4040206@redhat.com>	 <4522BCBF.2050508@aknet.ru> <1159905265.2891.551.camel@laptopd505.fenrus.org>
In-Reply-To: <1159905265.2891.551.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Arjan van de Ven wrote:
> and chmod o-x bash ....
> at which point.. game over.
> (and yes you can do in bash pretty much what you can do in perl. heck
> you can prove that.. shell is turning complete ;)
Can I do a syscalls from a bash script?
But in any case, I am not going to suggest any
solution against a script-loader - the mmap change
doesn't prevent that too.
Instead I'd like to evaluate a few ideas about an
ld.so problem. One of which is to _enforce_ the "noexec",
just as you asked for. :)
Please have a look at this patch:
http://uwsg.ucs.indiana.edu/hypermail/linux/kernel/0610.0/1402.html
The primary goal is to make access() to respect the "noexec".

