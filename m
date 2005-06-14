Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFNOSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFNOSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFNOSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:18:22 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:29752 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVFNOSN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:18:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QRvKIjjyCYkA16975RwHZipX1oNtvfxd2oPAiFbo/3lL1Q8EeIqCqTxI8kVFQ55g973KgvpSGIpPqaxwzccZBbkDD4ykafszU/XiPMdPks5Er9opVo3ZROgBE1ZC7qunZlbUs44eL4JCJXT7oAAQYykq2K/pw3KKJG90d10HUrM=
Message-ID: <ca992f11050614071857cd069b@mail.gmail.com>
Date: Tue, 14 Jun 2005 23:18:08 +0900
From: junjie cai <junjiec@gmail.com>
Reply-To: junjie cai <junjiec@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: is synchronize_net in inet_register_protosw necessary?
Cc: junjiec@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all.
i am a newbie to linux kernel.
in a arm926 board i found that it took about 30ms to finish
the (net/ipv4/af_inet.c:898) inet_register_protosw
because of the synchronize_net call during profiling.
synchronize_net finally calls synchronize_rcu, so i think
this is to make the change visiable after a list_add_rcu.
but according to the Document/listRCU.txt it seems that
a list insertation does not necessarily do call_rcu etc.
may i have any mistakes, please kindly tell me.
