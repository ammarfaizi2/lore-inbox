Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282236AbRLRKDv>; Tue, 18 Dec 2001 05:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282671AbRLRKDl>; Tue, 18 Dec 2001 05:03:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44561 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282236AbRLRKD2>; Tue, 18 Dec 2001 05:03:28 -0500
Date: Tue, 18 Dec 2001 10:02:44 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM driver patch summary
Message-ID: <20011218100244.B12774@flint.arm.linux.org.uk>
In-Reply-To: <1008638563.5515.96.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1008638563.5515.96.camel@thanatos>; from jdthood@mail.com on Mon, Dec 17, 2001 at 08:22:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 08:22:40PM -0500, Thomas Hood wrote:
> Finally, think carefully about where the cli() and sti() should go.

I believe the cli() and sti() to be correct - you shouldn't call
pm_send_all with IRQs off as it was previously.  pm_send_all is a
function that can sleep (check the down(&pm_devs_lock) call).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

