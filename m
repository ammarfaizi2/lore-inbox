Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290239AbSAQTuE>; Thu, 17 Jan 2002 14:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290260AbSAQTtz>; Thu, 17 Jan 2002 14:49:55 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:1299 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S290239AbSAQTto>;
	Thu, 17 Jan 2002 14:49:44 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200201171949.WAA04520@ms2.inr.ac.ru>
Subject: Re: arpd not working in 2.4.17 or 2.5.1
To: amit.gupta@amd.COM (Amit Gupta)
Date: Thu, 17 Jan 2002 22:49:17 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C45B97C.9F7466B5@cmdmail.amd.com> from "Amit Gupta" at Jan 16, 2 08:45:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> the master daemon tries to connect to systems >1024.. arp kills it with

Make echo 2048 > /proc/sys/net/ipv4/neigh/default/gc_thresh3
and live in peace.

arpd will _not_ help you at all. Without tuning above you are lost
in any case, with this tuning arpd is useless.

Not quite useless though, but its task has nothing to do with
size of table. Its task is reducing broadcasting on LAN, which is
importnat but a second order effect yet. Well, you can use arpd
from iproute2.

Alexey
