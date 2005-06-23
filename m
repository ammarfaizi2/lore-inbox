Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVFWPMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVFWPMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 11:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVFWPMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 11:12:34 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:30414 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262460AbVFWPMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 11:12:31 -0400
Message-ID: <42BAD15D.5030808@namesys.com>
Date: Thu, 23 Jun 2005 08:12:29 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Nikita Danilov <nikita@clusterfs.com>,
       "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       =?UTF-8?B?TWFya3VzIFTQlnJucXZpc3Q=?= <mjt@nysv.org>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <200506221733.j5MHXEoH007541@laptop11.inf.utfsm.cl>	<42B9DD48.6060601@slaphack.com> <17081.58619.671650.812286@gargle.gargle.HOWL> <42BAC668.2030604@slaphack.com>
In-Reply-To: <42BAC668.2030604@slaphack.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

> Nikita Danilov wrote:
>
> >David Masover writes:
>
> >[...]
>
> > >
> > > What we want is to have programs that can write small changes to one
> > > file or to many files, lump all those changes into a transaction, and
> > > have the transaction either succeed or fail.
>
> >No existing file system guarantees such behavior. Even atomicity of
> >single system call is not guaranteed.
>
>
> No _existing_ filesystem.  But I seem to recall that this was one of the
> design decisions of Reiser4, and that the system call itself was pushed
> off to 4.1?

Thats right.

>
> Maybe I'm just wrong about how big a transaction can be.

No, you are not.

Isolation is not easy for an fs, but fusing multiple atoms from multiple
file modifications into one "guaranteed to commit or fail all together"
atom is easy.
