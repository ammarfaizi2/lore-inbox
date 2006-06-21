Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWFUNIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWFUNIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFUNIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:08:11 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:666 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S1751559AbWFUNIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:08:09 -0400
From: Kirill Smelkov <kirr@mns.spb.ru>
Organization: MNS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: fix revision comparison in ide_in_drive_list
Date: Wed, 21 Jun 2006 17:11:13 +0400
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <200606201452.33925.kirr@mns.spb.ru> <200606211017.28987.kirr@mns.spb.ru> <1150890282.15275.54.camel@localhost.localdomain>
In-Reply-To: <1150890282.15275.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606211711.14731.kirr@mns.spb.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

21 Jun 2006 15:44, Alan Cox wrote:
> > id->model="TRANSCEND",
> > id->fw_rev="20050811TRANSCEND"
> > 
> > note the trailing in id->fw_rev,
> 
> These are not null terminated strings in the ident block. So if you
> merely print them or test against them you'll break on 8 char long
> firmware names. They may also be space rather than \0 padded if shorter
This justifies strstr usage.

Thanks again.

-- 
	Kirill

