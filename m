Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTF0Lob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 07:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTF0Loa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 07:44:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52612
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264231AbTF0Lna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 07:43:30 -0400
Subject: Re: [PATCH] 2.4.21-rc8 vesafb memory remapping...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Thomas Backlund <tmb@iki.fi>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.21.0306271340000.2794-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0306271340000.2794-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056714867.4348.36.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jun 2003 12:54:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-27 at 12:51, Geert Uytterhoeven wrote:
> 	Hi Marcelo,
> 
> Can we please have a fix for vesafb in the next -pre*? Currently it maps 8
> times too much memory due to a bits/bytes confusion.

You want to allocate a bit more than the minimum needed for the scroll
buffers and you also have to check for banked stuff. Thats fixed in -ac

