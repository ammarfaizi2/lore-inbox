Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbULHREn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbULHREn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbULHREn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:04:43 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:86 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261266AbULHREd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:04:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=lBwDEb7fQnBtspyfx+Esz0luB8vhy0iOOLf8MUNGIsrgHt9gOAEv3RKhghK0lh7kAjdbn5BJ1DewUYDGdVSQAMTp+xf2Pm+Ptg0X6vRkKWm4vNzC8K17UKbKfuAdIdEKqMkoEDqhNtayqPNYfaSEncwWd6VOflR7NPUgRqp2pcI=
Message-ID: <c25b2532041208090412b4bf54@mail.gmail.com>
Date: Wed, 8 Dec 2004 09:04:32 -0800
From: Richard Hubbell <richard.hubbell@gmail.com>
Reply-To: Richard Hubbell <richard.hubbell@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: large number of minor faults 2.6.10-rc1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed with the X process and with seti@home that they are
generating a large
number of minor faults. 

I fiddled around with these thinking it was all glibc's fault.  And
that reduced the number
(for seti, but didn't try with X)

setenv MALLOC_MMAP_MAX_ 0
setenv MALLOC_TRIM_THRESHOLD_ -1

I do see improved efficiencies after changing those glibc settings so
I am betting
that to reduce the number of minor faults even further will improve
efficiencies further.

I don't have any history of data to look at for previous kernels, so
would like to know
if anyone might like to try an educated guess as to what's going on.

I'll have to find some time to try with a previous kernel and see if it changes.
Or maybe it's purely an application problem

Thanks,
Richard
