Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265423AbTFZGQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 02:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265424AbTFZGQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 02:16:34 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:64985 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S265423AbTFZGQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 02:16:31 -0400
Date: Thu, 26 Jun 2003 08:30:42 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: Thijs <thijs@balpol.tudelft.nl>
cc: linux-kernel@vger.kernel.org, <alan@redhat.com>
Subject: Re: Linux 2.4.21-ac3
In-Reply-To: <3EFA0626.3060104@balpol.tudelft.nl>
Message-ID: <Pine.LNX.4.44.0306260819010.13520-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003, Thijs wrote:

> Since 2.4.21-ac2 i'm experiencing problems with Postfix on Debian
> Stable. Messages get corrupted while being handled by Postfix.
>
> Vanilla 2.4.21 and 2.4.21-ac1 are fine, but 2.4.21-ac2/3 causes
> problems. Going back to ac1 resolves the issue. I tried kernels on
> several Debian servers, but all have the same problem. Could be it's
> something in postfix that emerges with this specific patch, but it's at
> least curious. I'm not too familiar with this matter unfortunately.
>
> The only logentries i see are:
>
> postfix/qmgr[399]: warning: active/0/4/04E5B17E3F: too many length bits,
> record type 255
> postfix/qmgr[399]: warning: 04E5B17E3F: envelope records out of order
> postfix/qmgr[399]: warning: saving corrupt file "04E5B17E3F" from queue
> "active" to queue "corrupt"
> ...or just...
> postfix/smtp[536]: warning: corrupted queue file: active/C/7/C7AC317E3F
>
> Tested on: Intel PPro, Intel Celeron, AMD Duron
> Tested on: ext2 and ext3

I can confirm this problem. I use postfix 2.0.12 on a Debian woody
installation, all mails get corrupted. Postfix queue in on reiserfs, so
I think the bug is filesystem independent.

  Geller Sandor <wildy@petra.hos.u-szeged.hu>

