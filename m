Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbTFCPiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTFCPiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:38:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40429
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265056AbTFCPfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:35:51 -0400
Subject: Re: select for UNIX sockets?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3llwkauq5.fsf@defiant.pm.waw.pl>
References: <m3llwkauq5.fsf@defiant.pm.waw.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054651886.9233.35.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 15:51:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-03 at 01:08, Krzysztof Halasa wrote:
> Hi,
> 
> Should something like this work correctly?

Sort of. The wakeup may occur for several reasons and you need to check
the return (for signals). Also the wakeup can occur when there is room
but another thread fills it, or return room but not enough for a large
datagram. Those don't seem to be the case on your example



