Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbTEJQkv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbTEJQkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:40:51 -0400
Received: from 12-249-212-150.client.attbi.com ([12.249.212.150]:56227 "EHLO
	rekl.yi.org") by vger.kernel.org with ESMTP id S264443AbTEJQku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:40:50 -0400
Date: Sat, 10 May 2003 11:53:21 -0500 (CDT)
From: lkhelp@rekl.yi.org
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled *RESOLVED*
In-Reply-To: <Pine.LNX.4.53.0305092018530.16627@rekl.yi.org>
Message-ID: <Pine.LNX.4.53.0305101146550.1714@rekl.yi.org>
References: <Pine.LNX.4.53.0305092018530.16627@rekl.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003 lkhelp@rekl.yi.org wrote:

> I started testing 2.5.69, and I can't seem to get TCQ enabled on my 
> drives.  The test-tcq.pl script indicates that both drives in this 
> computer support TCQ:
> # ./test-tcq.pl
> /proc/ide/ide0/hda (WDC WD1200JB-00CRA1) supports TCQ
> /proc/ide/ide3/hdg (Maxtor 6E030L0) supports TCQ
> 


I looked at this a little more.  It seems that the test-tcq.pl that I
downloaded did not have the bit-shift operators correct.  I don't know how
that happened, but it caused it to report incorrectly the TCQ support for
my drives.

After looking at the bits in the "drive features supported" and comparing 
against the spec, neither drive supports TCQ.  The test-tcq.pl script with 
the correct bit-shift operators also shows that neither drive supports 
TCQ.

So, I guess you can ignore my previous message...

