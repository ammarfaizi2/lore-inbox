Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVI2K6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVI2K6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 06:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVI2K6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 06:58:22 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:2012 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932091AbVI2K6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 06:58:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Date: Thu, 29 Sep 2005 12:58:42 +0200
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
References: <200509281624.29256.rjw@sisk.pl> <200509282224.43397.rjw@sisk.pl> <20050928170031.D30088@unix-os.sc.intel.com>
In-Reply-To: <20050928170031.D30088@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509291258.43258.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 29 of September 2005 02:00, Siddha, Suresh B wrote:
> On Wed, Sep 28, 2005 at 10:24:42PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, 28 of September 2005 21:18, Andi Kleen wrote:
> > > Also Suresh S. has a patch out to turn the initial page tables
> > > into initdata. It'll probably conflict with that. Needs to be coordinated
> > > with him.
> > 
> > Do you mean the patch at:
> > http://www.x86-64.org/lists/discuss/msg07297.html ?
> > Unfortunately it interferes with the current swsusp code, which uses
> > init_level4_pgt anyway.
> > 
> > Could we please treat my patch as a (very much needed) urgent bugfix
> > and make the whole swsusp code in line with the Suresh's patch later on?
> > 
> > Suresh, could you please say what you think of it?
> 
> My patch as such shouldn't change the behavior of the existing swsup
> code. I am making only boot_level4_pgt as initdata. But not the 
> init_level4_pgt.

Then it should not conflict with my patch either, because I'm only referring
to init_level4_pgt.

Greetings,
Rafael
