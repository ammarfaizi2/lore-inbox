Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbTBCPfY>; Mon, 3 Feb 2003 10:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTBCPfY>; Mon, 3 Feb 2003 10:35:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39569
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266851AbTBCPfX>; Mon, 3 Feb 2003 10:35:23 -0500
Subject: Re: PnP Model
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mochel@osdl.org
In-Reply-To: <1044286316.1777.30.camel@mulgrave>
References: <1044286316.1777.30.camel@mulgrave>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044290479.21009.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 03 Feb 2003 16:41:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 15:31, James Bottomley wrote:
> The last issue is probably that we'd like the ISA probes to be run after
> all the rest of the busses so that all resources in use in the system

They need to run very early on in some ways. We don't want to assign a
PnP device over something we didnt know exists. We can scan the other
busses first safely but we can't activate devices or do anything else
until the ISA unsafe probes run. Those also have some very careful
ordering especially in networking. NE2000 must run early, other probes
can make some cards move around so must also be ordered


