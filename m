Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWJYXAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWJYXAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 19:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWJYXAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 19:00:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46788 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161067AbWJYXAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 19:00:17 -0400
Subject: Re: megaraid_sas waiting for command and then offline
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Brett G. Durrett" <brett@imvu.com>
Cc: "David N. Welton" <d.welton@webster.it>, linux-kernel@vger.kernel.org
In-Reply-To: <453FE9C4.1090504@imvu.com>
References: <453F2454.1000707@webster.it>  <453FE9C4.1090504@imvu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 00:03:35 +0100
Message-Id: <1161817415.7615.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-25 am 15:48 -0700, ysgrifennodd Brett G. Durrett:
> After I reported an additional failure, Sumant said they were able to 
> reproduce the problems with XFS but they have not seen it with EXT3. 

I've seen precisely that pattern with a couple of IDE controllers. In
both cases they had problems with very large I/O requests. XFS was
generating extremely long linear reads and writes while ext3 tended to
generate nice I/O patterns but never really huge ones.

(The IDE drivers in question have since been fixed except for IT821x
where some firmware versions in raid mode still barf)

Alan

