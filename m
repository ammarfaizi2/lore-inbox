Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTEHWBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbTEHWBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:01:09 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:17805 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262165AbTEHV7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:59:49 -0400
Date: Fri, 9 May 2003 00:12:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Jonathan Lundell <linux@lundell-bros.com>, root@chaos.analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030508221206.GA24216@wohnheim.fh-wedel.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <3EB957FA.4080900@us.ibm.com> <20030507200647.GB3166@wohnheim.fh-wedel.de> <3EB96916.7080900@us.ibm.com> <20030508084101.GE1469@wohnheim.fh-wedel.de> <3EBA8B04.5010704@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EBA8B04.5010704@us.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003 09:51:16 -0700, Dave Hansen wrote:
> Jörn Engel wrote:
> > If I read this correctly, your patch doesn't catch everything, if
> > there are functions remaining that use stack frames >0x200ul.  Ok,
> > tell me I'm wrong and should go through the assembler code first.
> 
> If any function is ever called with < 0x200 bytes of space left on the
> stack, it considers it an overflow.

Is that number before or after the function placed it's own stackframe
on the stack? If before, I'd rather increase that to 0x400 or even a
bit higher. But hopefully gcc is smarter than that.

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
