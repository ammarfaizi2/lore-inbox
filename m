Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWIHPnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWIHPnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWIHPnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:43:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41419 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750853AbWIHPno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:43:44 -0400
Date: Fri, 8 Sep 2006 11:49:45 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
Message-ID: <20060908154945.GI28592@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@sw.ru>,
	Kirill Korotaev <dev@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Fernando Vazquez <fernando@oss.ntt.co.jp>,
	"David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
	devel@openvz.org
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org> <44FFF1A0.2060907@openvz.org> <Pine.LNX.4.64.0609070816170.27779@g5.osdl.org> <4501891D.5090607@sw.ru> <Pine.LNX.4.64.0609080831530.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609080831530.27779@g5.osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 08:35:03AM -0700, Linus Torvalds wrote:
 > 
 > 
 > On Fri, 8 Sep 2006, Kirill Korotaev wrote:
 > > 
 > > I even checked the email myself and the only difference between "good"
 > > patches and mine is that mine has "format=flowed" in
 > > Content-Type: text/plain; charset=us-ascii; format=flowed
 > > 
 > > It looks like some mailers replace TABs with spaces when format=flowed
 > > is specified. So are you sure that the problem is in mozilla?
 > 
 > Hey, what do you know? Good call. I can actually just "S"ave the message 
 > to a file, and it is a perfectly fine patch. But when I view it in my mail 
 > reader, your "format=flowed" means that it _shows_ it as being corrupted 
 > (ie word wrapping and missing spaces at the beginning of lines).
 > 
 > Will apply, thanks. It would be better if your mailer didn't lie about the 
 > format though (treating the text as "flowed" definitely isn't right, and 
 > some mail gateways might actually find it meaningful, for all I know).

I got bitten by this myself a while ago. Since then I added this
hack to my .procmailrc

:0fw
| /usr/bin/perl -pe 's/^(Content-Type: .*)format=flowed/\1format=flawed/'

now I see patches as they were intended..

	Dave
