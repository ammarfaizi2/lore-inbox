Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286915AbSABKdK>; Wed, 2 Jan 2002 05:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286913AbSABKdA>; Wed, 2 Jan 2002 05:33:00 -0500
Received: from mail.s.netic.de ([212.9.160.11]:22021 "EHLO mail.netic.de")
	by vger.kernel.org with ESMTP id <S286790AbSABKcp>;
	Wed, 2 Jan 2002 05:32:45 -0500
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Wed, 02 Jan 2002 11:29:20 +0100
In-Reply-To: <87g05py8qq.fsf@fadata.bg> (Momchil Velikov's message of "02
 Jan 2002 01:03:25 +0200")
Message-ID: <87y9jh3v27.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Momchil Velikov <velco@fadata.bg> writes:

> -		strcpy(namep, RELOC("linux,phandle"));
> +		memcpy (namep, RELOC("linux,phandle"), sizeof("linux,phandle"));

Doesn't this still trigger undefined behavior, as far as the C
standard is concerned?  It's probably a better idea to fix the linker,
so that it performs proper relocation.
