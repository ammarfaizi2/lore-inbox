Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTIJLxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbTIJLxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:53:07 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:59848 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S262610AbTIJLxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:53:04 -0400
Date: Wed, 10 Sep 2003 13:52:59 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910115259.GA28632@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Luca Veraldi <luca.veraldi@katamail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Veraldi, Wed, Sep 10, 2003 11:18:48 +0200:
> > Will it be possible to base existing facilities on your approach?
> > SVR5 messages (msg{get,snd,rcv}), for example?
> 
> Ah, ok. So let's continue to do ineffient things
> only because it has always been so!

It is because the interface is perfectly enough. You still can
implement zero-copy local transfers for pipes for read and write
calls.
And for small amounts, where it is impossible to do zero-copy does not
bring noticable advantages (as was already mentioned by Alan).

> Compatibility is not a problem. Simply rewrite the write() and read()
> for pipes in order to make them do the same thing done by zc_send()
> and zc_receive().  Or, if you are not referring to pipes, rewrite the
> support level of you anchient IPC primitives in order to make them do
> the same thing done by zc_send() and zc_receive().

If it is possible, why new user-side interface?

-alex
