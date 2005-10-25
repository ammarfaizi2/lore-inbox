Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVJYWkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVJYWkT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVJYWkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:40:18 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:63674 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932454AbVJYWkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:40:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=JlvDebMR3783Wwj4HmFR3iw2te5Dnfxbb+xc5CIuTVTSUKxz4rU8qJZFkou4OPcWoazWt5L30qYcLB8zzB/OtWGmye94dh87XnaFK1rJHLLkkvl9qMQYOJHD2OdUiPNOmKyRxGiIyrNDZI2rVgIA912j4KCV0OmURNwDFl5xtLw=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/6] x86_64: fix L1_CACHE_SHIFT_MAX for Intel EM64T [for 2.6.14?]
Date: Wed, 26 Oct 2005 00:44:25 +0200
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20051025221105.21106.95194.stgit@zion.home.lan> <20051025221253.21106.22572.stgit@zion.home.lan> <200510260024.17241.ak@suse.de>
In-Reply-To: <200510260024.17241.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260044.26138.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 00:24, Andi Kleen wrote:
> > No correctness issues, obviously. So this could even be merged for 2.6.14
> > (I'm not a fan of this idea, though).
>
> I don't think it's a good idea to mess with this for 2.6.14

> In general the maxaligned stuff is imho bogus and should be removed. That
> is what CONFIG_X86_GENERIC is for. It doesn't make sense imho to separate
> the variables in two aligned classes - either they should be aligned in all
> cases or they shouldn't.

For what I see, that's based on the tradeoff between space and contention - 
for instance there are few zones only, so there's no big waste. In practice, 
interpreting !X86_GENERIC as "I will run this kernel on _this_ processor" 
could also be done.

However, in case you didn't note, max_align is never enough on EM64T 
currently, right?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
