Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWG3XlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWG3XlI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWG3XlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:41:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:40678 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932478AbWG3XlH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:41:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
Date: Mon, 31 Jul 2006 01:41:29 +0200
User-Agent: KMail/1.9.1
Cc: "Paul Jackson" <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200607301830.01659.jesper.juhl@gmail.com> <20060730113416.7c1d8f80.pj@sgi.com> <9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com>
In-Reply-To: <9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607310141.30354.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sunday 30 July 2006 20:48 schrieb Jesper Juhl:
> >     up
>
> I'd *love* to change this one - and down() as well - to up_sem() &
> down_sem(). But, making that change would be a pretty major and
> somewhat disruptive api change, so I opted instead to change the local
> variable names. I plan to introduce a sepperate patch set later on
> that adds up_sem()/down_sem() wrappers around up()/down(), deprecate
> the old names and add an entry to feature-removal.txt - but doing it
> now as part of the -Wshadow cleanup would be too much pain.

The path for getting rid of up()/down() is more along the lines
of replacing more semaphores with mutex variables. Once the only
users of up()/down() are those that really rely on counting semaphores,
it becomes much easier to do the change you proposed.

	Arnd <><
