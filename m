Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbSLKUaT>; Wed, 11 Dec 2002 15:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbSLKUaT>; Wed, 11 Dec 2002 15:30:19 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:55235
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267271AbSLKUaS>; Wed, 11 Dec 2002 15:30:18 -0500
Subject: Re: [PATCH] Notifier for significant events on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Levon <levon@movementarian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021211202727.GF20735@compsoc.man.ac.uk>
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net>
	<20021211165153.A17546@in.ibm.com> <20021211111639.GJ9882@holomorphy.com>
	<20021211171337.A17600@in.ibm.com> 
	<20021211202727.GF20735@compsoc.man.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 21:15:36 +0000
Message-Id: <1039641336.18587.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 20:27, John Levon wrote:
> There are notifiers being used that sleep inside the called notifiers.
> 
> You could easily make a __notifier_call_chain that is lockless and
> another one that readlocks the notifier_lock ...

The notifier chains assume the users will do the locking needed for
them. It might be possible to do cool things there with RCU

