Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270379AbTGWPO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 11:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270380AbTGWPO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 11:14:57 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:54485
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270379AbTGWPO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 11:14:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Tom Felker <tcfelker@mtco.com>
Subject: Re: root= needs hex in 2.6.0-test1-mm2
Date: Thu, 24 Jul 2003 01:33:36 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307230156.40762.tcfelker@mtco.com> <20030723144351.A3367@infradead.org>
In-Reply-To: <20030723144351.A3367@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307240133.36646.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 23:43, Christoph Hellwig wrote:
> On Wed, Jul 23, 2003 at 01:56:40AM -0500, Tom Felker wrote:
> > I finally booted 2.6.0-test1-mm2, after reading somebody else who needed
> > to use hex in the root= argument.  root=/dev/hdb1 and root=hdb2 would
> > panic ("VFS: Cannot open root device hdb1 or unknown-block(0,0)"), but
> > root=0341 worked.  Devfs is compiled in, devfs=nomount and devfs=mount
> > make no difference.  Is this intentional?
>
> Yes.  If you use devfs you have to use devfs names for root=.  It's
> pretty simple.  Best option of course is to avoid devfs.

ie use

root=/dev/ide/host0/bus0/target1/lun0/part1

or equivalent

