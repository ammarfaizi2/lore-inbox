Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131531AbQLMQye>; Wed, 13 Dec 2000 11:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131628AbQLMQyZ>; Wed, 13 Dec 2000 11:54:25 -0500
Received: from nella-gw.infonet.cz ([212.71.152.17]:5138 "EHLO mite.infonet.cz")
	by vger.kernel.org with ESMTP id <S131531AbQLMQyN>;
	Wed, 13 Dec 2000 11:54:13 -0500
Message-ID: <3A37A28B.7AC31112@infonet.cz>
Date: Wed, 13 Dec 2000 17:23:39 +0100
From: Marian Jancar <marian.jancar@infonet.cz>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with NAT
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem with nat in at least 2.2.16 and 2.2.18. If you
specify routing first and nat second,

ip route add nat x.x.x.x via y.y.y.y
ip rule add from y.y.y.y nat x.x.x.x

the rule doesnt have an effect, ping to x.x.x.x says it got response
from y.y.y.y. With turned order of commands,

ip rule ...
ip route ...

it works.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
