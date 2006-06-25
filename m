Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWFYRUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWFYRUI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWFYRUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:20:08 -0400
Received: from hera.kernel.org ([140.211.167.34]:10440 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751330AbWFYRUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:20:06 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Is the x86-64 kernel size limit real?
Date: Sun, 25 Jun 2006 10:19:52 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e7mgjo$oco$1@terminus.zytor.com>
References: <20060622204627.GA47994@dspnet.fr.eu.org> <p73hd2cnik6.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1151255992 24985 127.0.0.1 (25 Jun 2006 17:19:52 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 25 Jun 2006 17:19:52 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <p73hd2cnik6.fsf@verdi.suse.de>
By author:    Andi Kleen <ak@suse.de>
In newsgroup: linux.dev.kernel
>
> Olivier Galibert <galibert@pobox.com> writes:
> 
> > I get bitched at by the build process because the kernel I get is
> > around 4.5Mb compressed.  i386 does not have that limitation.
> > Interestingly, a diff between the two build.c gives:
> 
> A patch to fix it is already queued for 2.6.18
> 
> Also long term it might be completely dropped when the uncompressor
> moves to long mode.
> 

It can be completely dropped now (and the directories unified); the
size limitation on the uncompressed size can be enforced in the linker
script.

The uncompressor only needs to be in long mode to support > 4 GB.

	-hpa

