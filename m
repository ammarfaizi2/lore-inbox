Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSESVcI>; Sun, 19 May 2002 17:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315258AbSESVcH>; Sun, 19 May 2002 17:32:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55045 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315210AbSESVcH>;
	Sun, 19 May 2002 17:32:07 -0400
Message-ID: <3CE8198F.613F34CF@zip.com.au>
Date: Sun, 19 May 2002 14:30:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Aggarwal <neil@JAMMConsulting.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug in RedHat 7.3 -- Assertion failure in 
 journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"
In-Reply-To: <ENEBKGGOKDOEALIKAJMBOEIPCGAA.neil@JAMMConsulting.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Aggarwal wrote:
> 
> Hello:
> 
> My RedHat 7.3 machine just locked up and I could not reboot it.  I had
> to punch the reset button.
> 
> Here is what I found in the /var/log/messages file:
> May 19 12:50:16 server1 kernel: Assertion failure in
> journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"

SMP machine, presumably?

The RH7.3 kernel has a bugfix which has unhappily exposed another
bug: a race with bdflush.

I'm pretty sure that Red Hat's latest errata kernel fixes this.

Patches against 2.4.19-pre8 which fix this are at
	http://www.kernel.org/pub/linux/kernel/people/sct/ext3/v2.4/

-
