Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265584AbUALUKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbUALUKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:10:24 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:5305 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265584AbUALUKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:10:20 -0500
Message-ID: <4002FF88.3000303@t-online.de>
Date: Mon, 12 Jan 2004 21:11:52 +0100
From: detlef.grittner@t-online.de (Detlef Grittner)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de-AT; rv:1.4) Gecko/20030821
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.1: modprobe behaves strange
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: EqzVbGZLYeVfKz0NNkFf85aZDSQT63Yk16wGk7+c-Em5jLrh4hLGkZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using the x86_64 architecture branch and have simply copied the 
kernel into my configuration of a 2.4.21 kernel.

I have the following lines in /etc/modules.conf:

alias eth0 r8169

alias snd-card-0 snd-via82xx

With the 2.4.21 kernel everything worked fine, with the 2.6.1 kernel I 
get the following behavior:

modprobe eth0
(no error, but r8169 not loaded)

modprobe r8169
(module r8169 is loaded and works)

modprobe snd-card-0
(FATAL: Modul snd_card_0 not found)

modprobe snd-via82xx
(module snd-via82xx is loaded and works)


I'm not really a kernel expert and so I have to ask:
Am I right, that this could be a problem of the kernel?
Is this the wildcard problem that was fixed in mm1?
Should I try mm1 or where should I begin to search for the problem?

Detlef

