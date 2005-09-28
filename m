Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVI1HMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVI1HMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVI1HMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:12:35 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:28638 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030196AbVI1HMe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:12:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J8I1tVol129gw592MMDChIMmzfy93I6Xi2xt8MLqQdB0PE38JYWeqyKPeF0D2dITSFCZKGRsM08i9oDER5cQyuWrd3mdSCber4qVfBNb3huFsMbkOe4FUeVIVPwJZDdvsAQbYgkEOz1X+fsVLnmQlcg9IcjmokAfQolAW0eusiM=
Message-ID: <98b62faa050928001275d28771@mail.gmail.com>
Date: Wed, 28 Sep 2005 00:12:33 -0700
From: <iodophlymiaelo@gmail.com>
Reply-To: iodophlymiaelo@gmail.com
To: linux-kernel@vger.kernel.org
Subject: raw aio write guarantee
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just a quick question: How can a user-mode application ensure that an
AIO write on a raw block device (i.e. open()ed with O_DIRECT) has
really -really- been written to the disk and not residing in an on-disk
write cache where it could be lost in case of a power failure? Is
physical write guaranteed to have taken place before the AIO
completion? Or is there a system call that sends a cache flush
command to the drive (and waits for the drive to commit)?
