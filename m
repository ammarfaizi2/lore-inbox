Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267908AbRGaA2s>; Mon, 30 Jul 2001 20:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269117AbRGaA2i>; Mon, 30 Jul 2001 20:28:38 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2821 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S267908AbRGaA21>; Mon, 30 Jul 2001 20:28:27 -0400
Date: Tue, 31 Jul 2001 02:28:34 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731022834.F28253@emma1.emma.line.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <s5gvgkacqlm.fsf@egghead.curl.com> <Pine.LNX.4.33L.0107301358310.5582-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107301358310.5582-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Rik van Riel wrote:

> Hmmm, then maybe we'd just want some flag to fsync()
> telling the kernel to also sync the parent directory
> of the file and do whatever it needs to do to get the
> rename() or link() committed ?

Heck, you can't tell the kernel to do rename/link/open/unlink
synchronously in-band. This list doesn't care for other OS's. The
semantics FreeBSD (e. g.) offers ARE indeed documented.

This won't work out without kernel support. Portable reliability doesn't
come for free.

chattr +S is bad (slow). bloating all applications to include every
possible brain fart that the random FS inventor let go is even worse.
