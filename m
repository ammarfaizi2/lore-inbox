Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUACLNH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 06:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbUACLNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 06:13:06 -0500
Received: from lmdeliver02.st1.spray.net ([212.78.202.115]:34204 "EHLO
	lmdeliver02.st1.spray.net") by vger.kernel.org with ESMTP
	id S262687AbUACLND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 06:13:03 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Date: Sat, 3 Jan 2004 12:13:01 +0100
User-Agent: KMail/1.5.2
References: <200401021658.41384.ornati@lycos.it> <20040102213228.GH1882@matchmail.com> <1073082842.824.5.camel@tux.rsn.bth.se>
In-Reply-To: <1073082842.824.5.camel@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401031213.01353.ornati@lycos.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 January 2004 23:34, you wrote:
> On Fri, 2004-01-02 at 22:32, Mike Fedyk wrote:
> > Have there been any ide updates in 2.6.1-rc1?
>
> I see that a readahead patch was applied just before -rc1 was released.
>
> found it in bk-commits-head
>
> Subject: [PATCH] readahead: multiple performance fixes
> Message-Id:  <200312310120.hBV1KLZN012971@hera.kernel.org>
>
> Maybe Paolo can try backing it out.

YES, YES, YES...

Reveting "readahead: multiple performance fixes" patch performance came back 
like in 2.6.0.

2.6.0:
64        31.91
128      31.89
256      26.22
8192    26.26

2.6.1-rc1 (readahead patch reverted):
64	31.84
128	31.86
256	25.93
8192	26.16

I know these are only performance in sequential data reads... and real life 
is another thing... but I think the author of the patch should be informed 
(Ram Pai).

for Ram Pai:
_____________________________________________________________________
My first message:
http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/0004.html

This thread:
Strange IDE performance change in 2.6.1-rc1 (again)
http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/0289.html
(look at the graph)

Any comments?
_____________________________________________________________________

Bye

-- 
	Paolo Ornati
	Linux v2.4.23

