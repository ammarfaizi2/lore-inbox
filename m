Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbTJWBRC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 21:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTJWBRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 21:17:02 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:29083 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S261429AbTJWBRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 21:17:01 -0400
From: ndiamond@wta.att.ne.jp
To: marco.roeland@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RH7.3 can't compile 2.6.0-test8 (fs/proc/array.c)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20031023011658.9B576E1EA@smtp3.att.ne.jp>
Date: Thu, 23 Oct 2003 10:16:58 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Roeland wrote (privately but I hope not secretly :-)

> Perhaps working out the jiffies call in a separate variable
> long long tmp = jiffies_64_to_clock_t(...); and then using
> that in the sprintf() might work?

unsigned long long.

It worked.  I made this change after applying the patch
previously posted by Mr. Roeland.  I think the present
workaround might also work without the previous patch,
and will try it that way if I have time.

Again this is with Red Hat's nonstandard gcc 2.96.
At the moment it looks like Red Hat's gcc is to blame here.

