Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVH3DXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVH3DXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVH3DXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:23:36 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:9713 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932111AbVH3DXg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:23:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cJGKWNOgIGq+y2qEgyJbT29+z2S1phhrBjROPl+1gq8rC3YlTRV5G1y1AmneX6JuHm736q1K9v49Qb9EhttbSZ1sNN2l/1z/oMbURG3LFQDquAOazcjT6ithtIaS+biPaL052x9W2kSDoeo1oTcETrAJa6gKXWzoR8iWLvf4f9c=
Message-ID: <21c563b6050829202372189527@mail.gmail.com>
Date: Tue, 30 Aug 2005 11:23:35 +0800
From: zhang yuanyi <zhangyuanyi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: What about adding range support for u32 classifier?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone!

The "range support" may be puzzled, but I don't know how to express my
problem exactly because of my poor english.

Just take an example, I may need all udp packets received on eth0
which source port is greater than 53 going into flow 10:1,  and I only
wanna to type one tc command like this(In fact, I communicated with
kernel directly):

    tc filter add dev eth0 parent ffff: protocol ip prio 20 \
                                  u32 match udp sport gt 53 0xffff \
                                        match ip protocol 17 0xff\
                                   flowid 10:1

But I found I can't, because u32 classifier doesn't support matching
multi-value in one key.So I need to add (65535-53) keys to a u32
filter to implement this.

I intend to solve this problem by modifying u32 filter to match
multi-value in one key, but I am worrying the preformance.

Can someone give me some suggestions?

Sincerely.
Yuanyi Zhang
