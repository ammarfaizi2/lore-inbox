Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUBQUQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266580AbUBQUQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:16:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:7332 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266578AbUBQUQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:16:34 -0500
Date: Tue, 17 Feb 2004 12:16:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: zippel@linux-m68k.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       GCS <gcs@lsc.hu>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <20040217200545.GP1308@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
 <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
 <20040217200545.GP1308@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Adrian Bunk wrote:
> 
> Most likely the problem is CONFIG_I2C=m and the fact that FB_RADEON_I2C
> is a bool.
> 
> I don't know whether there's a better way to express this, but something 
> like the following is required:

Argh. Yeah, that's ugly.

How about instead just removing the dependency on I2C, and making it just
select it? (in fact, I'd assume that just selecing I2C_ALGOBIT should
itself cause I2C to be selected, but I've not checked the dependency
chain).

That's really what the true dependency is, logically.

		Linus
