Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266588AbUFVEZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266588AbUFVEZf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 00:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266586AbUFVEZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 00:25:26 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:62345
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S266582AbUFVEZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 00:25:19 -0400
From: Rob Landley <rob@landley.net>
To: Keith Owens <kaos@sgi.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Date: Mon, 21 Jun 2004 23:21:31 -0500
User-Agent: KMail/1.5.4
Cc: Takao Indoh <indou.takao@soft.fujitsu.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
References: <1642.1087796771@kao2.melbourne.sgi.com>
In-Reply-To: <1642.1087796771@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406212321.31112.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 June 2004 00:46, Keith Owens wrote:

> >this basically approximates your polling based implementation but uses
> >the existing kernel timer data structures and timer mechanism so should
> >be robust and compatible. It doesnt rely on any previous state (because
> >all currently pending timers are discarded) so it's as crash-safe as
> >possible.
>
> Don't forget live crash dumping.  The system is running and is behaving
> strangely so you want to take a dump for investigation, but you do not
> want to kill the system afterwards.  Live crash dumping is very useful
> for problem diagnosis.
>
> It is a little more complex than dumping after an oops because you must
> not destroy any kernel data, including timer lists.

How much does this differ from the proposed software suspend stuff based on 
some of the crash dumping code?

If you've got software suspend and LVM snapshots, the combination of the two 
could theoretically be pretty useful in an enterprise environment...

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

