Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVC0WqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVC0WqS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVC0WqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:46:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58894 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261612AbVC0WqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:46:14 -0500
Date: Sun, 27 Mar 2005 23:45:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a check after use)
Message-ID: <20050327234557.B17496@flint.arm.linux.org.uk>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050327205014.GD4285@stusta.de> <20050327232158.46146243.khali@linux-fr.org> <20050327214323.GH4285@stusta.de> <20050328003401.7b3cf380.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050328003401.7b3cf380.khali@linux-fr.org>; from khali@linux-fr.org on Mon, Mar 28, 2005 at 12:34:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 12:34:01AM +0200, Jean Delvare wrote:
> I think that you'd be better just telling the
> maintainers about the problem without providing an arbitrary patch, so
> that they will actually look into the problem with their advanced
> knowledge of the driver

FWIW, I agree with Jean.

Applying these patches without adequate review is like applying __iomem
or __user fixes where they've been generated with the aim of shutting up
sparse, rather than considering whether the warning is actually valid.
Once the warning is gone, the real problem is lost and never gets looked
at.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
