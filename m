Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269676AbTHBRIo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 13:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269696AbTHBRIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 13:08:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64004 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269676AbTHBRIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 13:08:43 -0400
Date: Sat, 2 Aug 2003 18:08:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stefan Jones <cretin@gentoo.org>
Cc: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>
Subject: Re: [2.6.0-test1] yenta_socket.c:yenta_get_status returns bad value compared to 2.4
Message-ID: <20030802180837.B1895@flint.arm.linux.org.uk>
Mail-Followup-To: Stefan Jones <cretin@gentoo.org>,
	linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>
References: <1059244318.3400.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1059244318.3400.17.camel@localhost>; from cretin@gentoo.org on Sat, Jul 26, 2003 at 07:31:59PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 07:31:59PM +0100, Stefan Jones wrote:
> It seems the the change from 2.4 to 2.6 made the state read from 
> yenta_get_status change it's return value. It reads it from hardware.

The get_status function is called multiple times during card
initialisation.  I doubt that it is valid to compare the get_status
values from 2.4 and 2.6 kernels, without examining what's going on
in the cs.c code.

It would be helpful if you could apply the patch to cs.c which I've
recently posted to lkml, and report back the full kernel messages,
including the messages you get from your printk in yenta_get_status().

The message id was: <20030802173352.A1895@flint.arm.linux.org.uk>

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

