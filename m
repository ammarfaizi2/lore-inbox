Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWIHNeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWIHNeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 09:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWIHNeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 09:34:16 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:604 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751104AbWIHNeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 09:34:15 -0400
Message-ID: <4501714F.9030709@tls.msk.ru>
Date: Fri, 08 Sep 2006 17:34:07 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Oleg Verych <olecom@flower.upol.cz>
CC: LKML <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: re-reading the partition table on a "busy" drive
References: <45004707.4030703@tls.msk.ru> <450105C0.2010603@flower.upol.cz> <Pine.LNX.4.61.0609080857090.30219@yvahk01.tjqt.qr> <20060908135858.GB14370@flower.upol.cz>
In-Reply-To: <20060908135858.GB14370@flower.upol.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Verych wrote:
[]
> My anwser to this question: if it's so "pretty annoying", just let it be
> "yes, do as i said !", not more and not less, just most ;).

Well, this whole question is already moot, as pointed out by Olaf.
Because kernel already supports add/delete single partition ioctls,
which is sufficient.  For my needs I already wrote a tiny hack which
compares /proc/partitions with the output of `sfdisk -d' and re-adds
anything which changed.  It should be possible to do the same with
parted instead of {sf,cf,f}disk without using that hack, but hell,
all those fdisks (parted included) sucks badly, each in its own way,
so all are being used for different parts of the task, including the
hack ;)

Thanks.

/mjt
