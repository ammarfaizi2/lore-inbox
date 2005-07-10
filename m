Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVGJKp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVGJKp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 06:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVGJKp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 06:45:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:10384 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261887AbVGJKp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 06:45:26 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Date: Sun, 10 Jul 2005 13:45:13 +0300
User-Agent: KMail/1.5.4
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       christoph@lameter.org
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708145953.0b2d8030.akpm@osdl.org> <Pine.LNX.4.58.0507081505230.17536@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507081505230.17536@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507101345.13291.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 July 2005 01:08, Linus Torvalds wrote:
> 
> On Fri, 8 Jul 2005, Andrew Morton wrote:
> > > 
> > > The previous value here i386 is 1000 --- so why is the default 250.
> > 
> > Because 1000 is too high.
> 
> Yes. I chose 1000 originally partly as a way to make sure that people that
> assumed HZ was 100 would get a swift kick in the pants. That meant making
> a _big_ change, not a small subtle one. For example, people tend to react
> if "uptime" suddenly says the machine has been up for a hundred days (even
> if it's really only been up for ten), but if it is off by just a factor of
> two, it might be overlooked.
> 
> So 1kHz was a bit of an overkill, but it worked well enough that we never 
> really got around to changing it. 

There are lots of HZ/100 in the kernel. With either 100 or 1000 it divides exactly,
but with 250 it's wrong by 20%.
--
vda

