Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUDVIYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUDVIYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbUDVIYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:24:12 -0400
Received: from denise.shiny.it ([194.20.232.1]:32176 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S263740AbUDVIYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:24:09 -0400
Message-ID: <XFMail.20040422102359.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20040421132047.026ab7f2.davem@redhat.com>
Date: Thu, 22 Apr 2004 10:23:59 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       cfriesen@nortelnetworks.com,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Apr-2004 David S. Miller wrote:
> On Wed, 21 Apr 2004 19:03:40 +0200
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> 
>> Heise.de made it appear, as if the only news was that with tcp
>> windows, the propability of guessing the right sequence number is not
>> 1:2^32 but something smaller.  They said that 64k packets would be
>> enough, so guess what the window will be.
>
> Yes, that is their major discovery.  You need to guess the ports
> and source/destination addresses as well, which is why I don't
> consider this such a serious issue personally.

Yes, but it is possible, expecially for long sessions. Also,
data injections is also possible with the same method, because
the receiver accepts everything inside the window, which is
usually 64k. Out of curiosity: in case Linux receives two
packets relative to the same portion of the stream, does it
check if the overlapping data is the same ? It would add extra
security about data injection in case the data has not been
sent to userspace yet.


--
Giuliano.
