Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754254AbWKMH6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbWKMH6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 02:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbWKMH6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 02:58:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3734 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754254AbWKMH6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 02:58:49 -0500
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1163374762.5178.285.camel@gullible>
References: <1163374762.5178.285.camel@gullible>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 08:58:47 +0100
Message-Id: <1163404727.15249.99.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> So my ultimate goal is to somehow move this decision making to udev. My
> plan is something along these lines:


well today you can already unbind from userspace.
The decision to bind automatically is the right one for the kernel,
since that is by far the most common one (99.9%+ of stuff has only one
driver ever) and also if you have no drivers it's just hard for udev to
run at all :)

udev can already unbind those few really rare cases it cares about, and
then do the other driver and bind that...... 

Now; there is a second issue. If the choice for one or the other is
consistent, we should consider fixing the kernel drivers to just not
advertise the b0rked one.. (this assumes that both drivers are in the
kernel and both are open source)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

