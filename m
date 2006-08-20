Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWHTRnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWHTRnd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWHTRnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:43:33 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3478 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750994AbWHTRnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:43:32 -0400
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Solar Designer <solar@openwall.com>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060820153037.GA20007@openwall.com>
References: <20060820003840.GA17249@openwall.com>
	 <20060820100706.GB6003@steel.home>  <20060820153037.GA20007@openwall.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:03:33 +0100
Message-Id: <1156097013.4051.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 19:30 +0400, ysgrifennodd Solar Designer:
> The problem is that there are lots of privileged userspace programs that
> do not bother to check the return value from set*uid() calls (or
> otherwise check that the calls succeeded) before proceeding with work
> that is only safe to do with the *uid switched as intended.

People keep saying this but we seem short of current, commonly shipped
examples. And quite frankly any code that doesn't check setuid returns
is unlikely to be fit for purpose in any other way and presumably has
never been adequately audited.

Alan

