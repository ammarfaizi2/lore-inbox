Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUJFSEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUJFSEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269328AbUJFSEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:04:38 -0400
Received: from [213.196.40.106] ([213.196.40.106]:54678 "EHLO
	eljakim.netsystem.nl") by vger.kernel.org with ESMTP
	id S268886AbUJFSEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:04:33 -0400
Date: Wed, 6 Oct 2004 20:04:29 +0200 (CEST)
From: Joris van Rantwijk <joris@eljakim.nl>
X-X-Sender: joris@eljakim.netsystem.nl
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <1097080873.29204.57.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0410061955230.7057@eljakim.netsystem.nl>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
 <1097080873.29204.57.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Many thanks to you everybody else for their helpfull comments.

On Wed, 6 Oct 2004, Alan Cox wrote:
> On Mer, 2004-10-06 at 15:52, Joris van Rantwijk wrote:
> > My understanding of POSIX is limited, but it seems to me that a read call
> > must never block after select just said that it's ok to read from the
> > descriptor. So any such behaviour would be a kernel bug.
>
> Select indicates there may be data. That is all - it might also be an
> error, it might turn out to be wrong.
>
> You should always combine select with nonblocking I/O

Ok, thanks. It turns out now that I (and a lot of people with me) have
always been wrong about this. I will go fix the application (dnsmasq) and
try to get the fix to the author.

Sorry about my wrongly blaming the kernel. I do think this issue shows hat
the select(2) manual needs fixing.

For clarity, I'd like to point out that my case has nothing to do with
multi-threading. Using select from multiple threads is a totally different
sort of mistake.

Bye,
  Joris.
