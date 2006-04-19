Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWDSQWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWDSQWT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWDSQWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:22:18 -0400
Received: from nproxy.gmail.com ([64.233.182.186]:12354 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750932AbWDSQWS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:22:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Y1ASgKpa4qKIj1ZnYR+myvQ8wyK0714iTOh8WQGMnrhyHPFkhN0s93tGNC6W5srbCeQRpAitJT8SifoW/BKXGT0Zz2rRfpUaqB71loBsBrT9M47yBez98SgLmFDwG/DTMbPl62UxcseUtxjZRyRuOmRSr5R6Xsln+JmT93va4m8=
Message-ID: <6d6a94c50604190922m189b9d99gdd428a870e12c2c3@mail.gmail.com>
Date: Thu, 20 Apr 2006 00:22:16 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Netpoll checksum issue
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm porting my network driver from 2.6.12 to 2.6.16. It almostly work
without any change, except the netpoll mode. When I use kgdb to debug
kernel, gdb client can not establish the connection with gdb server.
Then I digged into the code, and I found in the routine "__netpoll_rx"
in the file "net/core/netpoll.c", the "checksum_udp" call always
failed, but it works on 2.6.12.
Could you please give me some suggestions?
Thanks a lot.

Regards,
-Aubrey
