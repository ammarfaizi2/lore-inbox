Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbUJYOY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbUJYOY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUJYOYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:24:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:49638 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261395AbUJYOYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:24:32 -0400
Date: Mon, 25 Oct 2004 16:24:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: Temporary NFS problem when rpciod is SIGKILLed
In-Reply-To: <200410251702.58622.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.53.0410251622080.1778@yvahk01.tjqt.qr>
References: <200410251702.58622.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Trond.
>
>I observed a problem with NFS root in 2.6 kernel
>(actually it was a 2.5 back then).

Does it also happen on 2.4?

>I am using NFS root. At shutdown, when I kill
>all processes with killall5 -9, NFS temporarily
>misbehaves. I narrowed it down to rpciod feeling
>bad when signalled with SIGKILL:

I think this has to do that you kill some userspace application that is
necessary for NFS. I am not exactly sure which one it is (if at all), but I
have had problems mounting an NFS volume when started with -b option (mounting
the root however was done ok by the kernel)


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
