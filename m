Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbUBII7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 03:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUBII7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 03:59:41 -0500
Received: from news.cistron.nl ([62.216.30.38]:32746 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S264434AbUBII7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 03:59:40 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Does anyone still care about BSD ptys?
Date: Mon, 9 Feb 2004 08:59:39 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c07i5r$ctq$1@news.cistron.nl>
References: <c07c67$vrs$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1076317179 13242 62.216.29.200 (9 Feb 2004 08:59:39 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <c07c67$vrs$1@terminus.zytor.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?  I'm
>thinking of restructuring the pty system slightly to make it more
>dynamic and to make use of the new larger dev_t, and I'd like to get
>rid of the BSD ptys as part of the same patch.

bootlogd(8) which is used by Debian and Suse is started as the
first thing at boottime. It needs a pty, and tries to use /dev/pts
if it's there but falls back to BSD style pty's if /dev/pts isn't
mounted - which will be the case 99% of the time.

Mike.

