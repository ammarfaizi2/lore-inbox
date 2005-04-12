Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVDLVOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVDLVOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVDLVLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:11:23 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:6300 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262109AbVDLVGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:06:00 -0400
Date: Tue, 12 Apr 2005 23:01:52 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org, Alexander Nyberg <alexn@dsv.su.se>,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH 1/3] cifs: md5 cleanup - functions
Message-ID: <20050412210152.GB25512@electric-eye.fr.zoreil.com>
References: <OFF8FD24BE.BDEDEA22-ON87256FE0.00741B4F-86256FE0.0074FC27@us.ibm.com> <1113267099.5734.1.camel@smfhome.smfdom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113267099.5734.1.camel@smfhome.smfdom>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@austin.rr.com> :
[...]
> There was a patch suggested a year or so ago to remove the older cifs
> md5 implementation and have cifsencrypt.c use the newer Linux crypto
> API, but since it made the code considerably more complex it did not
> make any sense. The current crypto API seems to be designed for much
> more complex usage patterns than cifs needs it for. The key use for this
> for CIFS is the following small function (to calculate the packet
> signitures on cifs packets in fs/cifs/cifsencrypt.c)

If you have the patches from 10/2003 in mind, they suffered more from poor
taste than from cryptoapi imho.

Btw nobody cared about fs/cifs/connect.c::CIFSNTLMSSPNegotiateSessSetup
(indentation from Mars + unchecked allocations before dereferences).

--
Ueimor
