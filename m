Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUDHLpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 07:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUDHLpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 07:45:04 -0400
Received: from news.cistron.nl ([62.216.30.38]:10628 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261672AbUDHLpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 07:45:00 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: dd PATCH: add conv=direct
Date: Thu, 8 Apr 2004 11:44:59 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c53dvr$911$1@news.cistron.nl>
References: <20040406220358.GE4828@hexapodia.org> <20040407220224.GA26850@sgi.com> <20040407220928.GI2814@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1081424699 9249 62.216.29.200 (8 Apr 2004 11:44:59 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040407220928.GI2814@hexapodia.org>,
Andy Isaacson  <adi@hexapodia.org> wrote:
>On Wed, Apr 07, 2004 at 05:02:24PM -0500, Nathan Straz wrote:
>> On Tue, Apr 06, 2004 at 05:03:58PM -0500, Andy Isaacson wrote:
>> > Linux-kernel:  is this patch horribly wrong?
>> ...
>> > to force O_DIRECT.  The enclosed patch adds a "conv=direct" flag to
>> > enable this usage.
>> 
>> Adding the functionality to conv= doesn't seem right to me.  conv= is
>> for converting the data in some way.  This is just changing the way data
>> is written.  Right?
>
>There's already conv=notrunc which means "open without O_TRUNC".  I
>agree that it's a nonintuitive interface, but then, the entire dd(1)
>command line is.

Well as you already added iflags and oflags, it makes more sense to
use those. oflags=fsync makes more sense to me than conv=fsync.
Likewise oflags=notrunc.

Mike.

