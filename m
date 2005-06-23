Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbVFWSdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVFWSdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVFWSdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:33:22 -0400
Received: from web30710.mail.mud.yahoo.com ([68.142.200.143]:47232 "HELO
	web30710.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262922AbVFWSaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:30:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2nGvXHPXAYcUVlG8JedWpNSIXGAabL39cHV4hJoTWiu7/Y4njD782QwZFgB1OdAhGwLdvFyercVFABOefVWdeMgtK9kCg2ku1Z8xWDzfB6jEfrN3CZ9Lop8ynG6JAs1k1D+3M6rtEBTNcMUQs7ReP/WVxT86jPH7p2iwqqMVzHU=  ;
Message-ID: <20050623183051.98655.qmail@web30710.mail.mud.yahoo.com>
Date: Thu, 23 Jun 2005 11:30:51 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050622204308.GC26925@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jens Axboe <axboe@suse.de> wrote:
> Journalled file systems will behave worse for this, because it has to
> tend to the journal as well. Can you try mounting that partition as ext2
> and see what numbers that gives you?

I did the tests again on a partition that I could mkfs/mount at will.

On ext3, I get about 33 seconds average latency.

And on ext2, as predicted, I have latencies in average of about 0.4 seconds.

I also tried reiserfs, and it gets about 22 seconds latency.

As you pointed out, it seems that there is a flow in the way IO queues and
journals (that are in some ways queues as well), interact in the presence of
flushes.

Nicolas

