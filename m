Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423590AbWJaQyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423590AbWJaQyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423595AbWJaQyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:54:25 -0500
Received: from mail.parknet.jp ([210.171.160.80]:24584 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1423590AbWJaQyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:54:23 -0500
X-AuthUser: hirofumi@parknet.jp
To: Holden Karau <holdenk@xandros.com>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       "akpm\@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       holden@pigscanfly.ca, holden.karau@gmail.com,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
References: <454765AC.1050905@xandros.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 01 Nov 2006 01:54:11 +0900
In-Reply-To: <454765AC.1050905@xandros.com> (Holden Karau's message of "Tue\, 31 Oct 2006 10\:03\:08 -0500")
Message-ID: <87mz7cqvd8.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holden Karau <holdenk@xandros.com> writes:

> From: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com
> This is an attempt at improving fat_mirror_bhs in sync mode [namely it
> writes all of the data for a backup block, and then blocks untill
> finished]. The old behavior would write & block in smaller chunks, so
> this should be slightly faster. It also removes the fix me requesting
> that it be fixed to behave this way :-)

Please post the result of performance test.  If it's fairly big, we
would be able to use async for mirror FAT. Instead, for hotplug device
we can provide the another option.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
