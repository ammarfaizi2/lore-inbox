Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290993AbSBGARC>; Wed, 6 Feb 2002 19:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290988AbSBGAQr>; Wed, 6 Feb 2002 19:16:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33042 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290984AbSBGAQK>; Wed, 6 Feb 2002 19:16:10 -0500
Message-ID: <3C61C72B.1010105@zytor.com>
Date: Wed, 06 Feb 2002 16:15:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
In-Reply-To: <20020206163118.E21624@devserv.devel.redhat.com> <E16YcJW-0006vG-00@the-village.bc.nu> <20020206191233.I21624@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:

> 
> We have changed it already (e.g,. for regparm(1), fewer relocs, shorter insn
> sequences, etc.), but with exception of 2 non-dynamic relocs (which get
> different numbers) we are still compatible.
> But as written later, just using a different GDT descriptor could avoid
> having to change the ABI, but would still have the undesirable property of
> requiring every app to mmap a new page at fixed location.

>

It's not that bad, though, especially if your fixed location is just
beneath the standard mmap base address (e.g. 0x3f000000 -- leave some room
for future expansion -- or thereabouts on the standard 3:1 split space.)

Do you support tlsalloc() or whatever it is called?

	-hpa

