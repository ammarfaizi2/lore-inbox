Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWBFIlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWBFIlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWBFIlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:41:44 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:55242 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750776AbWBFIlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:41:44 -0500
Message-ID: <43E70BE3.1080805@t-online.de>
Date: Mon, 06 Feb 2006 09:42:11 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: carlos@fisica.ufpr.br
CC: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: nfsroot doesn't work with intel card since 2.6.12.2/2.6.11
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: TtfEJrZOgeq5v79n7nLwmttTHeOLhG2HcBb+NPEeW7v68k2LFHc2ZM@t-dialin.net
X-TOI-MSGID: 6a2511dd-4087-4ce6-82ca-16a88aefc07e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos,

Could you give some more information?

1. How do you boot the kernel? Bootrom?
    If yes: Which protocol? PXE + pxelinux? Etherboot? ...

2. Does ip auto configuration (e.g. ip=dhcp at kernel command line) work?
    If you do see the "IP-Config: Complete:" message while booting with
    ip=dhcp or ip=bootp or if you don´t see it is a very valuable 
information.

3. Does portmap lookup work? If ip auto configuration does not work and
    you try to give the information on the command line, this will most
    probably fail too, but please give it a try.

4. Could it be that you try to mount root using nfs version 2?
    The current linux nfs 2 server is unable to serve the current nfs 2 
client.
    Unfortunately  version 2 is the default. Add the v3 parameter:

        root=/dev/nfs nfsroot=%s,rsize=8192,wsize=8192,v3


cu,
 Knut
