Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTKLFcQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 00:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbTKLFcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 00:32:16 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:5904 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S261753AbTKLFcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 00:32:14 -0500
Date: Wed, 12 Nov 2003 06:32:07 +0100
From: Willy Tarreau <willy@w.ods.org>
To: kirk bae <justformoonie@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: So, Poll is not scalable... what to do?
Message-ID: <20031112053207.GA9634@alpha.home.local>
References: <LAW12-F60bw5TYIo9WF0002bec8@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LAW12-F60bw5TYIo9WF0002bec8@hotmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 05:52:42PM -0600, kirk bae wrote:
> If poll is not scalable, which method should I use when writing 
> multithreaded socket server?

Honnestly, if you're using threads (I mean lots of threads, such as one
per connection), I don't think that poll performance will be your worst
ennemy. The first thing to do is to handle the task switching yourself
either with a publicly available coroutine library or with one of your own.

Take a look here for more a comparison of several available methods :

    http://www.kegel.com/c10k.html

epoll is compared to other methods with numbers here :

    http://www.xmailserver.org/linux-patches/nio-improve.html

Cheers,
Willy

