Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264888AbUFAFZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbUFAFZj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 01:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUFAFZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 01:25:39 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:31460 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264888AbUFAFZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 01:25:38 -0400
Date: Tue, 1 Jun 2004 07:25:11 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040601052511.GB15492@wohnheim.fh-wedel.de>
References: <20040527145935.GE23194@wohnheim.fh-wedel.de> <4382.1085670482@ocs3.ocs.com.au> <20040527152156.GI23194@wohnheim.fh-wedel.de> <1085672066.7179.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1085672066.7179.3.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004 17:34:26 +0200, Arjan van de Ven wrote:
> 
> you can write "add 100,%esp" as "sub -100, %esp" :)
> compilers seem to do that at times, probably some cpu model inside the
> compiler decides the later is better code in some cases  :)

That and even worse things.  sys_sendfile has a "sub $0x10,%esp"
followed by an "add $0x20,%esp".  Can you explain that one as well?
0x20 is the size of all automatic variables on i386.

I have no idea what kind of trick gcc is playing there, but it appears
to work which makes me only more curious.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
