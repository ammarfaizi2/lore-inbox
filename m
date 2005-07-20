Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVGTS5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVGTS5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 14:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVGTS5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 14:57:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31135 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261476AbVGTSzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 14:55:21 -0400
Message-ID: <42DE9D80.3070905@redhat.com>
Date: Wed, 20 Jul 2005 14:52:48 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Blunck <j.blunck@tu-harburg.de>
CC: Chris Wedgwood <cw@f00f.org>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de> <20050719191648.GA24444@taniwha.stupidest.org> <20050720112127.GC3890@wohnheim.fh-wedel.de> <20050720181101.GB11609@taniwha.stupidest.org> <42DE9C71.7090903@tu-harburg.de>
In-Reply-To: <42DE9C71.7090903@tu-harburg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck wrote:

>
> I don't want to tell where these are in general, I need an easy way to 
> seek to the m'th directory + offset position without reading every 
> single dirent. With i_sizes != 0 it is straight forward to use "the 
> sum of the m directory's i_sizes + offset" as the f_pos to seek to. 
> For this purpose it is not necessary to have a "honest" i_size as long 
> as the i_size is bigger than the offset of the last dirent in the 
> directory.
>

You are not going to get this functionality.  It is simply not how 
directories
work nowadays.  Very few file systems are going to be usable if you insist
upon this semantic.  It is simply not possible to guess, with variable sized
entries and with distributed directory structures.

       ps
