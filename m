Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTGGLSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTGGLSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:18:33 -0400
Received: from dyn-ctb-210-9-243-115.webone.com.au ([210.9.243.115]:15110 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263894AbTGGLSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:18:32 -0400
Message-ID: <3F095A65.4070100@cyberone.com.au>
Date: Mon, 07 Jul 2003 21:32:53 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Process scheduler fairness bug (feature?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,
In recent testing unrelated to your interactivity stuff,
I have found the following with 74-mm2, although I don't
think its due to your interactivity stuff.

I don't have a real workload that is bothered by this btw.
Just wondering if its fixable, or there is a reason for it.

On UP, 2 processes of same priority. One is doing an
infinite loop of nothing, the other doing an infinite loop
of fork+waiting for children which count to a million then
exit (do a bit of work).

The non forking CPU hog gets 75% of the cpu.


