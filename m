Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbTE1NqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbTE1NqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:46:05 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:57003 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264733AbTE1NqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:46:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@digeo.com>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Thu, 29 May 2003 00:00:11 +1000
User-Agent: KMail/1.5.1
Cc: axboe@suse.de, m.c.p@wolk-project.de, manish@storadinc.com, andrea@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com>
In-Reply-To: <20030528032315.679e77b0.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305290000.12116.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003 20:23, Andrew Morton wrote:
> Could you please work out which change caused it?  Go back to stock 2.4 and
> then apply this:
>
[snip] 1

> then this:
[snip] 2

> Then this (totally unlikely, don't bother):
[snip] 3

Ok patch combination final score for me is as follows in the presence of a 
large continuous write:
1 No change
2 No change
3 improvement++; minor hangs with reads
1+2 improvement+++; minor pauses with switching applications
1+2+3 improvement++++; no pauses

Applications may start up slowly that's fine. The mouse cursor keeps spinning 
and responding at all times though with 1+2+3 which it hasn't done in 2.4 for 
a year or so.

Con
