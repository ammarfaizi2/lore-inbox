Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275900AbTHOKOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275901AbTHOKOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:14:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48138 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275900AbTHOKOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:14:48 -0400
Date: Fri, 15 Aug 2003 11:14:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying to run 2.6.0-test3
Message-ID: <20030815111442.A12422@flint.arm.linux.org.uk>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	linux-kernel@vger.kernel.org
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Fri, Aug 15, 2003 at 05:11:42PM +0900
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 05:11:42PM +0900, Norman Diamond wrote:
> 1.  Although both yenta and i82365 are compiled in, my 16-bit NE2000 clone
> isn't recognized.  If I boot kernel 2.4.19 I can use the network, if I
> boot kernel 2.6.0 I can't find any way to use the network.  Partial output
> of various commands and files are shown below.

As a general rule, you should be using yenta not i82365.  There have
been some historical problems when you build both into the kernel,
so you might like to try disabling i82365.

I don't see any sign of cardmgr starting up in your message logs, and
cardmgr is still required to tell the kernel which resources it can
use, and to bind the driver to the device.

Start cardmgr and it should work.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

