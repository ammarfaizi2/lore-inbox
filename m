Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTFJOIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTFJOIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:08:47 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:49286 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262931AbTFJOIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:08:45 -0400
To: Timothy Miller <miller@techsource.com>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: select for UNIX sockets?
References: <MDEHLPKNGKAHNMBLJOLKOEKFDIAA.davids@webmaster.com>
	<m3isredh4e.fsf@defiant.pm.waw.pl> <3EE5DE7E.4090800@techsource.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 10 Jun 2003 16:21:28 +0200
In-Reply-To: <3EE5DE7E.4090800@techsource.com>
Message-ID: <m3k7buxbbr.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> writes:

> If you were to use blocking writes, and you sent too much data, then
> you would block.  If you were to use non-blocking writes, then the
> socket would take as much data as it could, then return from write()
> with an indication of how much data actually got sent.  Then you call
> select() again so as to wait for your next opportunity to send some
> more of your data.

This is all true in general but in this particular case of unix datagram
sockets select (poll) is just buggy.
-- 
Krzysztof Halasa
Network Administrator
