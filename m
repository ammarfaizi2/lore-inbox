Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266110AbUGJCeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUGJCeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 22:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266105AbUGJCeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 22:34:13 -0400
Received: from holomorphy.com ([207.189.100.168]:42625 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266096AbUGJCeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 22:34:05 -0400
Date: Fri, 9 Jul 2004 19:30:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040710023045.GD21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@fs.tum.de>, Arjan van de Ven <arjanv@redhat.com>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Jakub Jelinek <jakub@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au> <20040708120719.GS21264@devserv.devel.redhat.com> <20040708205225.GI28324@fs.tum.de> <20040708210925.GA13908@devserv.devel.redhat.com> <1089324501.3098.9.camel@nigel-laptop.wpcb.org.au> <20040709062403.GA15585@devserv.devel.redhat.com> <20040710012117.GA28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710012117.GA28324@fs.tum.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 08:24:03AM +0200, Arjan van de Ven wrote:
>> one thing to note is that you also need to monitor stack usage then :)
>> inlining somewhat blows up stack usage so do monitor it...

On Sat, Jul 10, 2004 at 03:21:17AM +0200, Adrian Bunk wrote:
> How could inlining increase stack usage?

As more variables go into scope, gcc's stack slot allocation bug bites
progressively harder and stackspace requirements grow without bound.


-- wli
