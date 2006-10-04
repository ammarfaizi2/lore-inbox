Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWJDTqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWJDTqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWJDTqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:46:46 -0400
Received: from mail.aknet.ru ([82.179.72.26]:12301 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750919AbWJDTqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:46:44 -0400
Message-ID: <4524101E.4090202@aknet.ru>
Date: Wed, 04 Oct 2006 23:48:46 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru> <45169C0C.5010001@aknet.ru>	 <4516A8E3.4020100@redhat.com> <4516B2C8.4050202@aknet.ru>	 <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org>	 <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru> <9a8748490610041102n69c5ee15s1c01675aca84625a@mail.gmail.com>
In-Reply-To: <9a8748490610041102n69c5ee15s1c01675aca84625a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Jesper Juhl wrote:
> So first you mount /dev/shm with 'noexec', thereby telling the system
> "please make shared memory non executable".
Well, what do I want to tell to the system when
mounting /dev/shm with "noexec" is a difficult
point to discuss. In my opinion (and it was so
for ages) I only tell it to not execute the
binaries from there. In your opinion I am saying
to make the shared memory not executable, but on
the other hand I am just mmaping some file, and
mmaping a file with PROT_EXEC never required an
exec perm for that file, so I wonder why "noexec"
is different here.
But as I said, this is a bit difficult to discuss,
so I was trying to avoid touching MAP_SHARED for now.
Please tell me how your logic applies to MAP_PRIVATE
instead, which is affected the same way. (considering
mprotect, MAP_ANONYMOUS then read(), "ro" not denying
PROT_WRITE, etc)

