Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270402AbTGSP6g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 11:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270403AbTGSP6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 11:58:36 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:29314 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S270402AbTGSP6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 11:58:31 -0400
Message-ID: <3F196E29.20606@comcast.net>
Date: Sat, 19 Jul 2003 09:13:29 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ocran@gmx.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise fasttrack raid, changed disk, unable to boot.
X-Enigmail-Version: 0.76.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

I recently ran across something similar after having received a warranty
replacement drive. Mine turned out to be some real funky geometry being
reported by the ide-disk layer. I came up with a fix, that worked for
me, not sure how universal it is. See the thread at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105840994419059&w=2

My patch that is attached in the first message of the thread is not
recommended, but the final simple fix worked also in my case. Does Linux
perhaps see the other drive with strange geometry? You can check with

cat /proc/ide/hd?/geometry

In my case, the head count reported by Linux was 255, which was bogus
and caused the problem. Hope this helps,

-Walt



