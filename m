Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUG2HrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUG2HrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 03:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266580AbUG2HrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 03:47:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34009 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263733AbUG2HrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 03:47:20 -0400
Message-ID: <4108AB1A.1050706@redhat.com>
Date: Thu, 29 Jul 2004 00:45:30 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: viro@parcelfarce.linux.theplanet.co.uk,
       "David S. Miller" <davem@redhat.com>, Chris Wedgwood <cw@f00f.org>,
       linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
References: <233602095@toto.iv>	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>	<20040728154523.20713ef1.davem@redhat.com>	<20040729000837.GA24956@taniwha.stupidest.org>	<20040728171414.5de8da96.davem@redhat.com>	<20040729002924.GK12308@parcelfarce.linux.theplanet.co.uk> <16648.42669.907048.112765@wombat.chubb.wattle.id.au>
In-Reply-To: <16648.42669.907048.112765@wombat.chubb.wattle.id.au>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

> With hot cache the system time is really small.

But this is not all you'll have to look at.

Single application performs does not really tell the whole story.  If
you touch more memory, more cache is used.  In SMP machines the cost of
cacheline transfers are added.  And in multi-core processors the cores
even share some cache which means every bit used might decrease system
performance ever so slightly.

If the added complexity is manageable the avoided memory operations
should be a win even if you cannot directly measure it.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
