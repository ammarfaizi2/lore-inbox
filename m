Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTFDLSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 07:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTFDLSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 07:18:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20611
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263234AbTFDLST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 07:18:19 -0400
Subject: Re: partition table problem with 2.4.21-rc7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Montecchiani <luca.montecchiani@teamfab.it>
Cc: Narayan Desai <desai@mcs.anl.gov>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EDD9E5C.9060902@teamfab.it>
References: <87brxemtev.fsf@mcs.anl.gov>  <3EDD9E5C.9060902@teamfab.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054722814.9359.95.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jun 2003 11:33:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-04 at 08:23, Luca Montecchiani wrote:
> I've have that annoying messages too and I've verified that the
> source of the problem is :
> 
> > CONFIG_BLK_DEV_IDEDISK=m
> 
> the ide code check the partition-table twice, but the first
> time without the ide-disk module and so the error...

That would make sense. The drive is attached to the null driver at
the point something tried to read the partition table initially. That
errors all I/O requests since they are meaningless.

I guess we shouldnt be partition probing those devices. I'll take a
look

