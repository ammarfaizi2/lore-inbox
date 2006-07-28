Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752002AbWG1Qgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbWG1Qgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbWG1Qgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:36:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32742 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752002AbWG1Qgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:36:42 -0400
Subject: Re: Driver timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       "Larson, Greg" <GLarson@analogic.com>
In-Reply-To: <Pine.LNX.4.61.0607281152030.5161@chaos.analogic.com>
References: <Pine.LNX.4.61.0607281152030.5161@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 17:55:32 +0100
Message-Id: <1154105732.13509.157.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-28 am 11:54 -0400, ysgrifennodd linux-os (Dick Johnson):
> 
> Hello list,
> What is the correct error code for a driver to return if
> the requested operation timed out?

If the operation is blocking then 
	ETIMEDOUT - if a timeout occurred
	
possibly also
	ETIME	  - if a timer of some kind expired

If you know why it timed out you may want to return that instead to
provide more information (eg the net code returns things like 'Host
down')


