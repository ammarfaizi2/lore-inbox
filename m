Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbUCUB2R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 20:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbUCUB2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 20:28:17 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:1935 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263587AbUCUB2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 20:28:16 -0500
Date: Sun, 21 Mar 2004 02:28:01 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Robin Holt <holt@sgi.com>
cc: Ragnar =?iso-8859-1?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       lkml <linux-kernel@vger.kernel.org>,
       Arthur Corliss <corliss@digitalmages.com>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: [patch,rfc] BSD accounting format rework
In-Reply-To: <20040319211457.GA19662@lnx-holt>
Message-ID: <Pine.LNX.4.53.0403210222020.24035@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.53.0403161414150.19052@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.53.0403191424480.19032@gockel.physik3.uni-rostock.de>
 <20040319191916.GQ1066@vestdata.no> <20040319211457.GA19662@lnx-holt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Robin Holt wrote:

> How about breaking the ac_version structure down as two nibbles?  One
> half being the major version and the other half being a minor version.
> The major version, when changed, means the structure is no longer compatible.
> The minor version can be changed when existing fields are not modified
> in either form or function.

Yes, I also thought about it. But now that we've used up all available
padding there is no way of binary compatible changes. And if we allow
variable size accounting file entries, we have to store their size
anyways. Which would then make an even better version indicator, as
Ragnar suggested.

Tim
