Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbTF2VOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbTF2VOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 17:14:09 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:2946 "EHLO
	lapdancer.baythorne.internal") by vger.kernel.org with ESMTP
	id S264908AbTF2VOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 17:14:03 -0400
Subject: Re: [PATCH] Fix mtdblock / mtdpart / mtdconcat
From: David Woodhouse <dwmw2@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
In-Reply-To: <20030629213450.B5653@flint.arm.linux.org.uk>
References: <20030623010031.E16537@flint.arm.linux.org.uk>
	 <1056544988.24294.9.camel@passion.cambridge.redhat.com>
	 <20030629213450.B5653@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat UK Ltd.
Message-Id: <1056922045.6616.28.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Sun, 29 Jun 2003 22:27:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-29 at 21:34, Russell King wrote:
> While looking over the changes between 1.5 and 1.6, I spotted this.  You
> may want to fix this change:
> 
> -                   concat->mtd.eccsize != subdev[i]->eccsize) {
> +                   concat->mtd.eccsize != subdev[i]->eccsize ||
> +                   !concat->mtd.read_ecc != !concat->mtd.read_ecc ||
> +                   !concat->mtd.write_ecc != !concat->mtd.write_ecc ||
> +                   !concat->mtd.read_oob != !concat->mtd.read_oob ||
> +                   !concat->mtd.write_oob != !concat->mtd.write_oob) {

Oops. Fixed in CVS.

-- 
dwmw2

