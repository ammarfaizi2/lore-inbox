Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbUAIUde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUAIUdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:33:33 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:39692 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264325AbUAIUdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:33:32 -0500
Date: Fri, 9 Jan 2004 21:33:27 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PATCH 1/2: Make gotoxy & siblings use unsigned variables
Message-ID: <20040109213327.A2699@pclin040.win.tue.nl>
References: <1073672901.2069.15.camel@laptop-linux> <Pine.LNX.4.53.0401091415430.571@chaos> <1073677435.2069.23.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1073677435.2069.23.camel@laptop-linux>; from ncunningham@users.sourceforge.net on Sat, Jan 10, 2004 at 08:43:55AM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Shouldn't we be using "size_t" for unsigned int

> You might be right. I was just being consistent with the other definitions.

These are character positions on a screen.
When did you last see a console in text mode with a line length
of more than 2^31 ?

If you go for a minimal patch then you should replace "char"
in one or two places by "unsigned char" and that is all.

