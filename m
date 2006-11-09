Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424160AbWKIRa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424160AbWKIRa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424162AbWKIRa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:30:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:17930 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424160AbWKIRaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:30:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Xm8bvHvkKllSVWSkn4Us/RhIrrLbERQKxScxNS/sK3jL7T8WSAGdhThTTDyhjFcVDjnb/zs3tEmQWfVCXnhO7rPQQaylv4kkloVxQDzE8LV1CI2f3mFRPq4tDuDmyQS9vqWQh9FZZ04WJVyPEuvMWxU/Byzi9Cd4PJwEspL1htU=
Message-ID: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
Date: Thu, 9 Nov 2006 20:30:23 +0300
From: "Igor A. Valcov" <viaprog@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: XFS filesystem performance drop in kernels 2.6.16+
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For one of our projects we have a test program that measures file
system performance by writing up to 1000 files simultaneously. After
installing kernel v2.6.16 we noticed that XFS performance dropped by a
factor of 5 (tests that took around 4 minutes on kernel 2.6.15 now
take around 20 minutes to complete). We then checked all kernels
starting from 2.6.16 up to 2.6.19-rc5 with the same unpleasant result.
The funny thing about all this is that we chose XFS for that
particular project specifically because it was about 5 times faster
with the tests than the other file systems. Now they all take about
the same time.

I also noticed that I/O barriers were introduced in v2.6.16 and
thought they may be the cause, but mounting the file system with
'nobarrier' doesn't seem to affect the performance in any way.

Any thoughts on the matter are appreciated.

Thanks in advance,

-- 
Igor A. Valcov
