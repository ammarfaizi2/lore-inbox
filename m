Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbTHYFuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 01:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbTHYFug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 01:50:36 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:46980 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261620AbTHYFuf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 01:50:35 -0400
Date: Mon, 25 Aug 2003 06:50:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jakob Oestergaard <jakob@unthought.net>,
       Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
       jim.houston@ccur.com
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030825055028.GE20529@mail.jlokier.co.uk>
References: <1061498486.3072.308.camel@new.localdomain> <20030825040514.GA20529@mail.jlokier.co.uk> <20030825041423.GB29987@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825041423.GB29987@unthought.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:
> > Jim you can answer this as you have such a Ppro.  Could you please run
> > this very simple userspace program for me, and report the result?
> > 
> > 	int main() { __asm__ ("sysenter"); return 0; }
> 
> I tested on two boxes:
> 
> Stepping 1 ppro:  SIGSEGV
> Stepping 7 ppro:  SIGSEGV

Thank you!

So that means the sysenter instruction _does_ exist on the PPro and
early Pentium II, but it isn't usable.

It's safe so long as it is disabled, but as you found, when you enable
and use it, it doesn't work as expected.  (I wonder what the actual
behaviour of sysenter/sysexit are on these CPUs.)

-- Jamie
