Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTELMeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTELMeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:34:18 -0400
Received: from angband.namesys.com ([212.16.7.85]:6273 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262098AbTELMeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:34:17 -0400
Date: Mon, 12 May 2003 16:46:54 +0400
From: Oleg Drokin <green@namesys.com>
To: lkhelp@rekl.yi.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030512124654.GA2699@namesys.com>
References: <Pine.LNX.4.53.0305092018530.16627@rekl.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0305092018530.16627@rekl.yi.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, May 09, 2003 at 08:38:51PM -0500, lkhelp@rekl.yi.org wrote:
> I started testing 2.5.69, and I can't seem to get TCQ enabled on my 
> drives.  The test-tcq.pl script indicates that both drives in this 
> computer support TCQ:
> # ./test-tcq.pl
> /proc/ide/ide0/hda (WDC WD1200JB-00CRA1) supports TCQ
> /proc/ide/ide3/hdg (Maxtor 6E030L0) supports TCQ
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device ide/host2/bus1/target0/lun0/par, size 
> 8192, journal first block 18, max trans len 1024, max batch 900, max 
> commit age 30, max trans age 30
> reiserfs: checking transaction log (ide/host2/bus1/target0/lun0/par) for 
> (ide/host2/bus1/target0/lun0/par)

Just a note that we have found TCQ unusable on our IBM drives and we had 
some reports about TCQ unusable on some WD drives.

Unusable means severe FS corruptions starting from mount.
So if your FSs will suddenly start to break, start looking for cause with
disabling TCQ, please.

Bye,
    Oleg
