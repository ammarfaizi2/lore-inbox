Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSFJSoh>; Mon, 10 Jun 2002 14:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSFJSog>; Mon, 10 Jun 2002 14:44:36 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:4498 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315709AbSFJSof> convert rfc822-to-8bit; Mon, 10 Jun 2002 14:44:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Mark Zealey <mark@zealos.org>, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Mon, 10 Jun 2002 20:44:22 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <20020610110740.B30336@ayrnetworks.com> <20020610183321.GA21687@itsolve.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206102044.22173.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > These two, in conjunction, would provide a buffer that's aligned on a
> > cacheline boundary and ends on a cacheline boundary. Kind of ugly, but
> > would be sufficient and would hide the cacheline size specifics.
> > Cache-coherent platforms would just returned the original argument.
>
> Why not just make some dmalloc() macro in pci.h which will do the
> nessecory magic resizing and alignments? seems a lot easier to do...

That won't be enough. We need a solution for buffers that are parts of
structures.

	Regards
		Oliver


