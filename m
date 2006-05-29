Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWE2OQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWE2OQB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 10:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWE2OQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 10:16:01 -0400
Received: from [129.97.134.17] ([129.97.134.17]:44779 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750896AbWE2OQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 10:16:01 -0400
Date: Mon, 29 May 2006 10:14:47 -0400
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
Message-ID: <20060529141447.GA18892@csclub.uwaterloo.ca>
References: <44793100.50707@perkel.com> <200605281854.08371.s0348365@sms.ed.ac.uk> <200605281920.02609.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605281920.02609.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 07:20:02PM +0100, Alistair John Strachan wrote:
> Five minutes of research and I found this:
> 
> http://www.asus.com.tw/products4.aspx?modelmenu=2&model=952&l1=3&l2=14&l3=245
> 
> It indicates that the board, although using an nForce 410 chipset, does NOT 
> use NVIDIA ethernet, but (quote) "Relatek RTL8201CL external PHY"; you're 
> probably trying the wrong driver and this is the source of the problem.
> 
> This info could be wrong, but I thought it might help.

The linux driver is for the MAC, which is in the chipset.  The PHY is
external, and it doens't particularly matter which one it is in general.
The driver almost never has to care.  I know I don't have to tell the
pcnet32 driver that I am using a broadcom 5221 PHY with it.  It works
just fine because the MAC is an AMD 972 which is one fo the chips the
pcnet32 driver operates.

Len Sorensen
