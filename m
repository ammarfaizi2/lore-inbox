Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVA3Tlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVA3Tlk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 14:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVA3Tlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 14:41:40 -0500
Received: from news.cistron.nl ([62.216.30.38]:5538 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261771AbVA3Tli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 14:41:38 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Pipes and fd question. Large amounts of data.
Date: Sun, 30 Jan 2005 19:41:38 +0000 (UTC)
Organization: Cistron
Message-ID: <ctjd9i$mvf$2@news.cistron.nl>
References: <200501301115.59532.ods15@ods15.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1107114098 23535 194.109.0.112 (30 Jan 2005 19:41:38 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (mikevs)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200501301115.59532.ods15@ods15.dyndns.org>,
Oded Shimon  <ods15@ods15.dyndns.org> wrote:
>I have implemented this, but it has a major disadvantage - every 'write()' 
>only write 4k at a time, never more, because of how non-blocking pipes are 
>done. at 20,000 context switches a second, this method reaches barely 10mb a 
>second, if not less.

If you're using pipe(), you might want to try socketpair()
instead. You can setsockopt() SO_RCVBUF and SO_SNDBUF to
large values if you want.

Mike.

