Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUDHHTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 03:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUDHHTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 03:19:43 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:1691 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262003AbUDHHTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 03:19:42 -0400
Subject: Re: [PATCH] reiserfs v3 fixes and features
From: Yury Umanets <umka@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1081344323.30829.534.camel@watt.suse.com>
References: <1081274618.30828.30.camel@watt.suse.com>
	 <1081343178.3042.2.camel@firefly>
	 <1081344323.30829.534.camel@watt.suse.com>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1081408913.3030.23.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 08 Apr 2004 10:22:04 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 16:25, Chris Mason wrote:
> On Wed, 2004-04-07 at 09:06, Yury Umanets wrote:
> 
> > That would be nice to have also improved locking in this
> > features-improvements-fixes patch set. Ask Oleg, he had intention to
> > work on and probably has something done already.
> > 
> 
> I'm assuming you mean getting rid of the BKL, which would be really
> nice. 
yes
>  I'd like to get the current patchset stabilized and in the
> kernel, but even moving to a per fs spin lock instead of the bkl would
> be a welcome change.
> 
> -chris

Last time we have discussed this with Oleg, he said, that there are lots
of stuff relying on the fact, that bkl can be acquired many times by the
same process. And simple replacing bkl by per-superblock lock makes life
just horrible ;)

There something like bkl but per-superblock based is needed. Or lots of
code should be changed, which is not good idea.

But anyway, this should be done one day, and if I have free time
(probably vacation) and it will not be done until that time, I'd like to
work on it along with Oleg and you ;)

-- 
umka
-- 
umka

