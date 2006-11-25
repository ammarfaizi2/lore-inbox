Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757894AbWKYIco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894AbWKYIco (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757891AbWKYIco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 03:32:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35534 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757894AbWKYIco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 03:32:44 -0500
Subject: Re: Overriding X on panic
From: Arjan van de Ven <arjan@infradead.org>
To: Casey Dahlin <cjdahlin@ncsu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1164434093.10503.2.camel@localhost.localdomain>
References: <1164434093.10503.2.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 25 Nov 2006 09:32:41 +0100
Message-Id: <1164443561.3147.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-25 at 00:54 -0500, Casey Dahlin wrote:
> Linus did say that he would do anything within reason to help desktop
> linux forward, and frankly a big step forward would be to get error
> messages to the user. What might be some safe options for overriding,
> switching away from, killing, or otherwise disposing of the X server
> when an unrecoverable Oops is about to occur on the TTY?

the "real" solution is to have a small video driver in the kernel that
knows at least how to get back to text mode. It sounds obscene to some,
but if you get down to it it's not all that bad; the policy of what
modesettings to use can still be in userspace, the execution of the
series of IO's would be in the kernel, and the kernel would store
bundles of settings, including a "rescue" one, but also for
suspend/resume...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

