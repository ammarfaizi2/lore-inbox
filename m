Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTE3OqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 10:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTE3Ops
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 10:45:48 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:17640 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263729AbTE3Opa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 10:45:30 -0400
Date: Fri, 30 May 2003 16:58:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/char/sysrq.c
Message-ID: <20030530145851.GA15640@wohnheim.fh-wedel.de>
References: <5.1.0.14.2.20030530164138.00aeee40@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5.1.0.14.2.20030530164138.00aeee40@pop.t-online.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 16:44:55 +0200, Margit Schubert-While wrote:
> 
> In drivers/char/sysrq.c (2.4 and 2.5) we have :
> 
>         if ((key >= '0') & (key <= '9')) {
>                 retval = key - '0';
>         } else if ((key >= 'a') & (key <= 'z')) {
> 
> Shouldn't the "&" be (pedantically) "&&" ?

It is semantically the same.  If you can show that gcc optimization
also creates the same assembler code, few people will object to a
patch.

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
