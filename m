Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbVKPHsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbVKPHsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbVKPHsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:48:39 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:7287 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030205AbVKPHsi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:48:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RgLNd7sqB/qekwmMo/406FhClojo4Cm0gcFxWJkpfVkLD0JwH2z0+59NL9P+m44zdMB5HIs1NC5gzNvvfUujdpRCvpdtSlQuQ0wijCiqT2g5h36KajV5TaTHe+Nr0F+g3EbKmxJeX1MpGFYGEzBoNnbtGMnXZ4+pfVmeb97HtiE=
Message-ID: <6d6a94c50511152348h1fab72fes@mail.gmail.com>
Date: Wed, 16 Nov 2005 15:48:34 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Alarm execl failed on 2.6.12
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I got a problem on 2.6.12. As follows:
-test.c
int main(void)
{
 alarm(3);
 execl("sig_rev","sig_rev","3",0);
 sleep(10);
 return 0;
}
-sig_rev.c
int main(void)
{
 sleep(10);
 return 0;
}
Running test can't stop in 3 seconds. But it should be.
Because the case can run properly on 2.6.11 and 2.6.13.
What difference about it?
Welcome any suggestions and comments
Thanks
-Aubrey
