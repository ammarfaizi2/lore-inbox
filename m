Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUJIMG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUJIMG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 08:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUJIMG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 08:06:27 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:40456 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S266721AbUJIMGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 08:06:25 -0400
Date: Sat, 9 Oct 2004 13:07:50 +0100
From: Colin Phipps <cph@cph.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041009120750.GA1948@cph.demon.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041007181658.2469.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007181658.2469.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So the performance gain is significant. And programs that break were
buggy anyway. But that still leaves the question of whether it benefits
users, given that there is a lot of software, buggy by this
interpretation, that can break. In particular, exposing UDP daemons to
denial of service using bad-checksum UDP packets looks like a rather
interesting security issue.

I have just tried syslog and inetd on a couple of machines running
2.6.8.1, and both hang when given a single bad-checksum udp packet.
hping2 -2 -c 1 -b is the tool of choice.  Sure, they could have broken
anyway, but this makes them easy targets - and presumably they are the
tip of the iceberg.

-- 
Colin Phipps <cph@cph.demon.co.uk>
