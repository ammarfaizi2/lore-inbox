Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTEAUKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTEAUKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:10:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13978
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262301AbTEAUKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:10:10 -0400
Subject: Re: [PATCH 0/4] NE2000 driver updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Muizelaar <muizelaar@rogers.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EB15127.2060409@rogers.com>
References: <3EB15127.2060409@rogers.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051817031.21546.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 20:23:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-01 at 17:53, Jeff Muizelaar wrote:
> Caveats:
> It appears that the patch will break any autoprobe ordering because it no
> longer uses Space.c when compiled into the kernel.

The ne2000 ordering with the other ISA stuff in space.c is really
sensitive for older systems. If you get ne2k too early it breaks some
other cards if it autoprobes, if you get it too late it lets other
stuff crash the box.

So you might want to keep to Space.c for non pnp stuff if non modular

