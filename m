Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbTGHAKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 20:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTGHAKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 20:10:21 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:51852 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264916AbTGHAKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 20:10:19 -0400
Date: Tue, 8 Jul 2003 01:24:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Eric Varsanyi <e0216@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
Message-ID: <20030708002444.GA12127@mail.jlokier.co.uk>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com> <20030707194736.GF9328@srv.foo21.com> <20030707200315.GA10939@mail.jlokier.co.uk> <Pine.LNX.4.55.0307071506560.4704@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307071506560.4704@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> It has to keep (file*, fd) as hashing key. That will work out just fine.

Do you mean epoll has to use (file*,fd) as the hash key?

> Not even thinking changing the API since it'll break existing apps.

Oh, you're right.  I forgot that apps wait for both read & write on
the same network fd... duh! :)

> The above trick will do it. Going to test it ...

Good-oh.

-- Jamie
