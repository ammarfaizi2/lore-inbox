Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTERQmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 12:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTERQmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 12:42:04 -0400
Received: from holomorphy.com ([66.224.33.161]:10465 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262127AbTERQmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 12:42:03 -0400
Date: Sun, 18 May 2003 09:54:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, ptb@it.uc3m.es,
       linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <20030518165445.GA8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, ptb@it.uc3m.es,
	linux-kernel@vger.kernel.org
References: <200305180921.h4I9LdD13274@oboe.it.uc3m.es> <19930000.1053275409@[10.10.2.4]> <20030518163537.GZ8978@holomorphy.com> <1053276543.1300.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053276543.1300.10.camel@laptop.fenrus.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Peter Breuer's attribution was removed from:
>>>> Here's a before-breakfast implementation of a recursive spinlock. That
>>>> is, the same thread can "take" the spinlock repeatedly. 

On Sun, May 18, 2003 at 09:30:17AM -0700, Martin J. Bligh wrote:
>>> Why?

On Sun, 2003-05-18 at 18:35, William Lee Irwin III wrote:
>> netconsole.

On Sun, May 18, 2003 at 06:49:04PM +0200, Arjan van de Ven wrote:
> not really.
> the netconsole issue is tricky and recursive, but recursive locks aren't
> the solution; that would require a rewrite of the network drivers. It's
> far easier to solve it by moving the debug printk's instead.

Yes, there are better ways to fix it. But AIUI this is why some people
want it (the rest of us just don't want messy locking semantics around).


-- wli
