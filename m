Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTEONt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbTEONt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:49:29 -0400
Received: from ppp-62-245-209-2.mnet-online.de ([62.245.209.2]:50050 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S264025AbTEONt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 09:49:28 -0400
Date: Thu, 15 May 2003 16:02:17 +0200
From: Julien Oster <lkml@frodoid.org>
To: linux-kernel@vger.kernel.org
Subject: "[BROKEN]" tag in config descriptions
Message-ID: <20030515140217.GA22774@frodo.midearth.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

what about adding a "[BROKEN]" tag to the short line descriptions of
config options, like "(NEW)" and "[EXEPERIMENTAL]" or "[DANGEROUS]"?

It should be used for config options that are known to currently not
compile at all.

That way, you could play with development kernels without the need to
recompile it three or four times, just because you realize: "Oh, yes, I
forgot, matrox_fb currently doesn't compile..."

(matrox_fb is actually a quite good example presently)

Don't misunderstand, the option should not be mandatory for everything
that doesn't compile (or just compiles under certain circumstances),
just for things that are really known to not compile at all, i.e. we
know that matrox_fb simply isn't ready yet in the current development
kernels and this even has been discussed in this mailing list.

Of course, this only makes really sense for development kernels, on
stable kernels everything should compile or else it's a bug (and nobody
knows that it won't compile)

To distinguish things better, this tag should only be for things that
don't COMPILE, wether they actually work or not. One might think about
introducing another tag for things that do compile but actually don't
work properly - meaning everything from "simply does nothing" to
"completely burn out your workstation case and shoot it into space" -
but I don't know if that really makes sense since in that situation it's
hard to say wether something will provide the desired functionality. (If
it always did, we wouldn't need development kernels :) )

Regards,
Julien

