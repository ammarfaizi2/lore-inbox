Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161741AbWKVFPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161741AbWKVFPd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 00:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161764AbWKVFPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 00:15:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:63366 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161741AbWKVFPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 00:15:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wpa/Swy2sQH5j0O2J0cCv8YbEyucdPPaai2M8o7xkwpcUL4V1/ujHn0DMvjq5V7/QDz1xx9r9oCb13AUDSL5ZCNmzOMpy2PFHoLAES7WCrrCqpEbZ5m0M/Dp/30FAK3Bc3+WYUHNLiBoeBb/47qz7AT2M/IFzffuzF5D4yl34Zg=
Message-ID: <e65b9ae80611212115r42dccbfcha51d9c1e52964e5e@mail.gmail.com>
Date: Wed, 22 Nov 2006 11:15:31 +0600
From: "Dilan Weerakkody" <dilan2005@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: MX21 keypad driver interrupt issue
In-Reply-To: <e65b9ae80611212102x2836f2d3ycb38a90ece2c4364@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e65b9ae80611212102x2836f2d3ycb38a90ece2c4364@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
i writing keypad driver on

*mx21 ads board  for
* kernel 2.6.14

i got a problem on interrupt handling ,

the isr routine for kpp

1.when interrupt occur first i disable interrupt by clear KRIE and KDIE bit

2.next i scan key pad matrix

3.clear KPDK bit  (but when i read this bit i can see that KPDK flag
bit is still not cleared)

4.then i enable KDIE bit again

all above 1,2,3,4 written within interrupt handler (is this a problem?);

my problem is KPP interrupt handler run over and over again after once
i touch a key and release it
please help
thanks

dilan
