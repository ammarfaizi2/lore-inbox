Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbTKZUIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbTKZUIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:08:04 -0500
Received: from holomorphy.com ([199.26.172.102]:22974 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264320AbTKZUIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:08:00 -0500
Date: Wed, 26 Nov 2003 12:07:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Message-ID: <20031126200754.GU8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311261415.52304.gene.heskett@verizon.net> <20031126193059.GS8039@holomorphy.com> <200311261443.43695.gene.heskett@verizon.net> <20031126195049.GT8039@holomorphy.com> <Pine.LNX.4.58.0311261202050.1524@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311261202050.1524@home.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, William Lee Irwin III wrote:
>> Okay, then we need to figure out what the hung process was doing.
>> Can you find its pid and check /proc/$PID/wchan?

On Wed, Nov 26, 2003 at 12:04:56PM -0800, Linus Torvalds wrote:
> I've seen this before, and I'll bet you 5c (yeah, I'm cheap) that it's
> trying to log to syslogd.
> And syslogd is stopped for some reason - either a bug, a mistaken SIGSTOP,
> or simply because the console has been stopped with a simple ^S.
> That won't stop "su" working immediately - programs can still log to
> syslogd until the logging socket buffer fills up. Which can be _damn_
> frsutrating to find (I haven't seen this behaviour lately, but I remember
> being perplexed like hell a long time ago).

That'll do it. Gene, could you check on syslogd too, then?


-- wli
