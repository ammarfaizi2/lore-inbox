Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVIRSzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVIRSzF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 14:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVIRSzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 14:55:05 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:24543 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932167AbVIRSzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 14:55:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=d4O4VvJcmyJH9PSYXg/jCd11RInlJzXIWx2qgYh+k4jdPNfMZrv4iu9FM6U8E/lpiXGWtX13qw6P4N7qR3A4PBsqFt4wnwvwqSX3GTixzz06WyJWSMkik0oDTI+Pw/5xM+xWHZrDDHMAS7uVaDbA15G7RbnnsXMZ55L3Fann9FQ=
Date: Sun, 18 Sep 2005 23:05:27 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: URB_ASYNC_UNLINK b0rkage
Message-ID: <20050918190526.GB787@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps, another press release to explain breakage of allmodconfig is
needed.
------------------------------------------------------------------------
drivers/usb/host/hc_crisv10.c:	if (urb->transfer_flags & URB_ASYNC_UNLINK) {
drivers/usb/host/hc_crisv10.c:		/* If URB_ASYNC_UNLINK is set:
drivers/usb/host/hc_crisv10.c:		warn("URB_ASYNC_UNLINK set, ignoring.");
drivers/usb/misc/uss720.c:	/* rq->urb->transfer_flags |= URB_ASYNC_UNLINK; */
drivers/isdn/hisax/st5481_b.c:	b_out->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
drivers/isdn/hisax/st5481_b.c:	b_out->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
drivers/isdn/hisax/st5481_usb.c:	in->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
drivers/isdn/hisax/st5481_usb.c:	in->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
Documentation/usb/URB.txt:the URB_ASYNC_UNLINK flag in urb->transfer flags before calling

