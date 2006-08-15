Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWHOObs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWHOObs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWHOObs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:31:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26772 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030311AbWHOObr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:31:47 -0400
Subject: Re: kernel BUG at <bad filename>:50307!
From: Arjan van de Ven <arjan@infradead.org>
To: mbraun@uni-hd.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44E1D9CA.30805@uni-hd.de>
References: <44E1D9CA.30805@uni-hd.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 15 Aug 2006 16:31:35 +0200
Message-Id: <1155652295.3011.165.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 16:27 +0200, Martin Braun wrote:
> Hello all,
> 
> I got this bug (see below) in my logs, the system showed with "top" an
> increasing load average of 11 and more but with an cpu-idle of 99% and
> no processes used mentionable resources, there were 6 zombies. A
> shutdown was not possible most of the samba processes  didn't respond to
> a kill.
> Before the exception the server was -as usual- under heavy load of samba
> processes 4-5 clients, with many automated activity (batch-processes
> with image processing).
> 
> What does this bug mean?

Hi,

it means you don't have CONFIG_KALLSYMS enabled, so the kernel isn't
able to give a decent debugging output in the oops.. if it's a
repeatable oops turning that option on would be a great help to even
figure out which part of the kernel is involved...

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

