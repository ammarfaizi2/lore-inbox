Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267788AbTAMQYn>; Mon, 13 Jan 2003 11:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbTAMQYn>; Mon, 13 Jan 2003 11:24:43 -0500
Received: from mail.isolate.net ([12.46.185.253]:9745 "HELO isolate.net")
	by vger.kernel.org with SMTP id <S267692AbTAMQYm>;
	Mon, 13 Jan 2003 11:24:42 -0500
Date: Mon, 13 Jan 2003 11:33:12 -0500
From: shuz@isolate.net
X-Mailer: The Bat! (v1.61) UNREG / CD5BF9353B3B7091
Reply-To: shuz@isolate.net
X-Priority: 3 (Normal)
Message-ID: <69415931157.20030113113312@isolate.net>
To: linux-kernel@vger.kernel.org
Subject: kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First let me apologize if this doesn't belong on the list, I wasn't
sure where to ask and I want to make sure this is a non-fatal error
(100% of the time).

www1 is a Dual PIII 733, 1G ram, eepro100 network card. gets around
15-35mbits of traffic.

www3 is a Dual P3 1GHZ with 1G ram, and also an eepro100 network card.
load balanced with www1, 15-35mbits of traffic.

around 5 days ago I updated to 2.4.20 (from 2.4.18) and noticed these
kernel (errors?) this morning at around the same time on each server.

Jan 13 09:12:38 www1 kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
Jan 13 09:12:38 www1 kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689)

Jan 13 09:08:44 www3 kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
Jan 13 09:08:44 www3 kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689)  

if someone could please provide insight on exactly what is happening
when this happens, it would be greatly appreciated. are there any side
effects? is this a kernel bug?

if you need more information please let me know.

Thanks,
Mike


