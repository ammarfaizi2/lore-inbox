Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWGUC6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWGUC6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 22:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWGUC6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 22:58:53 -0400
Received: from mail.tmr.com ([64.65.253.246]:25801 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S964892AbWGUC6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 22:58:51 -0400
Message-ID: <44C045B4.3040609@tmr.com>
Date: Thu, 20 Jul 2006 23:10:44 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>	 <20060705125956.GA529@fieldses.org>	 <1152128033.22345.17.camel@lade.trondhjem.org>  <44AC2D9A.7020401@tmr.com>	 <1152135740.22345.42.camel@lade.trondhjem.org>  <44B01DEF.9070607@tmr.com>	 <1152562135.6220.7.camel@lade.trondhjem.org>  <44B2D6AA.3090707@tmr.com> <1152585383.10156.9.camel@lade.trondhjem.org>
In-Reply-To: <1152585383.10156.9.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>On Mon, 2006-07-10 at 18:37 -0400, Bill Davidsen wrote:
>  
>
>Linus might accept it, but I won't. It is totally unnecessary.
>  
>

By "totally unnecessary" you mean "I don't see why it's useful."

The reason for using noatime is to avoid generating disk activity while 
the data is being accessed. It's not usually used to hide the fact that 
the data has been used and is therefore useful to someone. In a perfect 
world, where money is no object, all data is on very fast storage which 
never fails. In my world I would like to identify which data, source or 
documentation, has been referenced over some period of time. This is 
useful for moving some data to slower (yes I mean less expensive) storage.

It's also useful to identify stuff which no one has used in a very long 
time and which is a candidate for not being on line at all.

By keeping lazy track of access time it's possible to still have that 
data, with minimal disk access cost. And to some people that can be 
really useful, such as those of us who have to justify expenditures.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

