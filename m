Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269070AbUJEOqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269070AbUJEOqM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269068AbUJEOqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:46:12 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:2746 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269046AbUJEOqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 10:46:08 -0400
Message-ID: <4162B345.9000806@rtr.ca>
Date: Tue, 05 Oct 2004 10:44:21 -0400
From: Mark Lord <lsml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Anton Blanchard <anton@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Core scsi layer crashes in 2.6.8.1
References: <1096401785.13936.5.camel@localhost.localdomain>	<1096467125.2028.11.camel@mulgrave> 	<20041005114951.GD22396@krispykreme.ozlabs.ibm.com> <1096984590.1765.2.camel@mulgrave>
In-Reply-To: <1096984590.1765.2.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seem to be other holes/races in this and related code.

The QStor driver implements hot insertion/removal of drives.

One thing it has to cope with at present is, after notifying
the mid-layer that a drive has been removed, the mid-layer calls
back with a synchronize-cache command for that drive..

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
