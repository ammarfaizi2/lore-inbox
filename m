Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUFJUey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUFJUey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUFJUey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:34:54 -0400
Received: from ee.oulu.fi ([130.231.61.23]:27548 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261602AbUFJUex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:34:53 -0400
Date: Thu, 10 Jun 2004 23:34:42 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Pavel Machek <pavel@suse.cz>
Cc: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Dealing with buggy hardware (was: b44 and 4g4g)
Message-ID: <20040610203442.GA27762@ee.oulu.fi>
References: <20040531202104.GA8301@ee.oulu.fi> <20040605200643.GA2210@ee.oulu.fi> <20040605131923.232f8950.davem@redhat.com> <20040609122905.GA12715@ee.oulu.fi> <20040610200504.GG4507@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040610200504.GG4507@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 10:05:04PM +0200, Pavel Machek wrote:
> This should hit machines with 2GB ram too, right?
> Is it possible to find if it hits me? I get hard lockups on
> 2GB machine with b44, but they take ~5min.. few hours to
> reproduce...
>  
> It seems to me like this should hit very quickly.
> -- 
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
> 
Yikes!

With the 4:4 VM split it definately is instantaneous with > 1GB of memory, I
triggered it with 1.25G myself and never noticed anything wrong with just
1GB (allocation starts from the top it seems). With the standard 1:3 split I
don't think anything > 1GB ever gets used for skbuffs, but maybe there
are circumstances where this can happen? 

(Or the issue isn't fully understood yet, figuring out what breaks and what
doesn't was basically just trial and error :-/ )
