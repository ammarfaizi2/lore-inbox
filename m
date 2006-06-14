Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWFNAGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWFNAGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWFNAGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:06:20 -0400
Received: from relay01.pair.com ([209.68.5.15]:34821 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S964823AbWFNAGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:06:18 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Ben Greear <greearb@candelatech.com>
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Date: Tue, 13 Jun 2006 19:05:54 -0500
User-Agent: KMail/1.9.3
Cc: "Brian F. G. Bidulock" <bidulock@openss7.org>,
       Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse> <448F4D6F.9070601@candelatech.com>
In-Reply-To: <448F4D6F.9070601@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131906.16683.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 18:42, Ben Greear wrote:
> Chase Venters wrote:
> > At least some of us feel like stable module APIs should be explicitly
> > discouraged, because we don't want to offer comfort for code that
> > refuses to live in the tree (since getting said code into the tree is
> > often a goal).
>
> Some of us write modules for specific features that are not wanted in
> the mainline kernel, even though they are pure GPL.  Our life is hard
> enough with out people setting out to deliberately make things more
> difficult!

Fair enough, but if you are doing out of tree, pure GPL modules, 
EXPORT_SYMBOL_GPL() isn't a bad thing, is it?

Don't mistake me for actually having a big opinion specifically about this 
socket API's usage of EXPORT_SYMBOL()... just raising some points that I 
think apply to these decisions in general. I don't really see a compelling 
reason for EXPORT_SYMBOL() over EXPORT_SYMBOL_GPL() on the socket APIs 
though... I'm trying to imagine what kind of legitimate non-GPL modules might 
use them.

> Ben

Thanks,
Chase
