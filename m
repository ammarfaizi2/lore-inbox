Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWIMPAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWIMPAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 11:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWIMPAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 11:00:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9911 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750935AbWIMPAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:00:01 -0400
Subject: Re: Error binding socket: address already in use
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Lezoch <pledr@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1GNVuW-02KMfw0@fwd29.sul.t-online.de>
References: <1GNVuW-02KMfw0@fwd29.sul.t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Sep 2006 16:23:35 +0100
Message-Id: <1158161015.13977.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-13 am 14:41 +0000, ysgrifennodd Peter Lezoch:
> Hi,
> killing a server task that is operating on a UDP socket( AF_INET,
> SOCK_DGRAM, IPPROTO_UDP ), leaves the socket in an unclosed state. 

For UDP the socket closes at the point the last user of the socket
closes. For TCP there is a time delay mandated by the specification.

If you are seeing UDP sockets remain open when you kill a server make
sure it hasn't forked other processes and passed them the file handle.

