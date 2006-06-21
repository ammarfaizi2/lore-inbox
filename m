Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWFUL3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWFUL3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWFUL3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:29:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4737 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751504AbWFUL3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:29:41 -0400
Subject: Re: [PATCH] ide: fix revision comparison in ide_in_drive_list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kirill Smelkov <kirr@mns.spb.ru>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <200606211017.28987.kirr@mns.spb.ru>
References: <200606201452.33925.kirr@mns.spb.ru>
	 <20060620151950.21ad94d6.akpm@osdl.org>
	 <1150845122.15275.8.camel@localhost.localdomain>
	 <200606211017.28987.kirr@mns.spb.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 12:44:42 +0100
Message-Id: <1150890282.15275.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 10:17 +0400, ysgrifennodd Kirill Smelkov:
> id->model="TRANSCEND",
> id->fw_rev="20050811TRANSCEND"
> 
> note the trailing in id->fw_rev,

These are not null terminated strings in the ident block. So if you
merely print them or test against them you'll break on 8 char long
firmware names. They may also be space rather than \0 padded if shorter

Alan

