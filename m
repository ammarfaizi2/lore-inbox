Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966991AbWKVBL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966991AbWKVBL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966992AbWKVBL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:11:56 -0500
Received: from ping.uio.no ([129.240.78.2]:61159 "EHLO ping.uio.no")
	by vger.kernel.org with ESMTP id S966991AbWKVBLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:11:55 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sct@redhat.com,
       James Hunt <james@jameshunt.org.uk>
Subject: Re: [PATCH 1/3] ext2/3/4: enable "undeletable" file attribute.
References: <20061121221632.GA12422@localdomain>
	<200611220121.33522.arnd@arndb.de>
From: ilmari@ilmari.org (=?utf-8?q?Dagfinn_Ilmari_Manns=C3=A5ker?=)
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Mail-Copies-To: nobody
Date: Wed, 22 Nov 2006 01:11:35 +0000
In-Reply-To: <200611220121.33522.arnd@arndb.de> (Arnd Bergmann's message of
 "Wed, 22 Nov 2006 01:21:32 +0100")
Message-ID: <d8j3b8c70ag.fsf@ritchie.ping.uio.no>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Exiscan-Spam-Score: -7.8 (-------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> On Tuesday 21 November 2006 23:16, James Hunt wrote:
> > ... it's not honoured by the kernel:
> > 
> >   > rm /tmp/wibble             # yikes! this should fail!!
>
> I always thought of the term 'undeletable' to mean that you can
> undelete the file (restore it) after it has been deleted. Of course,
> this is not implemented either, but it means something very different
> than what your patch does.

That is indeed what the documented (but not implemented) meaning is.
>From chattr(1):

|       When a file with the ‘u’ attribute set is deleted, its contents
|       are saved. This allows the user to ask for its undeletion.

So the meaning is undelete-able, not un-deletable.

-- 
ilmari
"A disappointingly low fraction of the human race is,
 at any given time, on fire." - Stig Sandbeck Mathisen
