Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUHEWXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUHEWXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267906AbUHEWKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:10:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:22975 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267897AbUHEWId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:08:33 -0400
Subject: Re: ide-cd problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040805054056.GC10376@suse.de>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de>
	 <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de>
	 <20040731210257.GA22560@bliss>  <20040805054056.GC10376@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091739966.8418.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 22:06:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-05 at 06:40, Jens Axboe wrote:
> Ok, that is definitely more acceptable. But then it should be done to
> CDROM_SEND_PACKET as well, and we risk breaking programs doing so (ie
> cdrecord run by user currently).

Definitely. Irrespective of any questions like filtering commands having
/dev device access allow you to compromise the entire system is not a
good model. CAP_SYS_RAWIO is the capability for "can do anything" so
seems appropriate here.


