Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936410AbWK3N0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936410AbWK3N0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 08:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936412AbWK3N0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 08:26:07 -0500
Received: from www.osadl.org ([213.239.205.134]:40583 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S936410AbWK3N0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 08:26:04 -0500
Subject: Re: Incorrect behavior of timer_settime() for absolute dates in
	the past
From: Thomas Gleixner <tglx@linutronix.de>
To: John <me@privacy.net>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, johnstul@us.ibm.com,
       akpm@osdl.org
In-Reply-To: <455D7CDD.9000202@privacy.net>
References: <455D7CDD.9000202@privacy.net>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 30 Nov 2006 14:26:01 +0100
Message-Id: <1164893161.6242.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 10:11 +0100, John wrote:
> value specified by the it_value member of value. If the specified time 
> has already passed, the function shall succeed and the expiration 
> notification shall be made."

That's exactly what the implementation does:

The functions succeeds (return value is 0) and then the notification is
made. There is _NO_ requirement that the signal is delivered before the
function returns to user space. I could be implemented, but I'm not sure
if it is worth the effort.

	tglx





