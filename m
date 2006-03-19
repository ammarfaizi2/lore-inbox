Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWCSQ5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWCSQ5G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 11:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWCSQ5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 11:57:06 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:56375 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751512AbWCSQ5F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 11:57:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HZCvsavNqd3iv161/y6kH6IyQFvQaeqfcqAGXOe3SeREEGOJI4W9lQRwjDZ2WRIBWP1kpWq/urIIv4J3UatNRfRR2ysriWGzf8z8IiA83dul/ahkXWDCIWxYv3FHAnuolm8GvLf4SoMpexVvMqfdTaUqDSljeb9OOW9HgfIVXME=
Message-ID: <bda6d13a0603190857p5cb466datd0395253ed263986@mail.gmail.com>
Date: Sun, 19 Mar 2006 08:57:02 -0800
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/stderr gets unlinked 8]
In-Reply-To: <E1FKmO8-000303-Ve@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5QeND-31x-7@gated-at.bofh.it> <5QE55-6Td-9@gated-at.bofh.it>
	 <5R778-8fs-29@gated-at.bofh.it> <5RgN2-5fi-3@gated-at.bofh.it>
	 <5RohF-7Oe-3@gated-at.bofh.it> <5Rpnz-ZJ-39@gated-at.bofh.it>
	 <E1FKmO8-000303-Ve@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/06, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
> > On Fri, 17 Mar 2006, Jan Engelhardt wrote:
>
> >> If not, you could write an LSM that prohibits unlinking /dev/stderr.
>
> > That symlink isn't even used -- at least by any sane program!
> > I don't have a clue why these things were created and what they
> > were for. The objects stdin, stdout, and stderr, are 'C' runtime
> > library pointers to opaque types associated with the file descriptors,
> > STDIN_FILENO, STDOUT_FILENO, and STDERR_FILENO. The presence of
> > these bogus sym-links in /dev represent some kind of obfuscation
> > and have no value except to confuse (or identify a RedHat distribution).
>
> Think about portable shell scripts. I remember /dev/std* longer than /proc.
They're from BSD (where they are real devices, with a major & minor number).
