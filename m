Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbUJYP1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUJYP1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUJYPYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:24:45 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22250 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261933AbUJYPUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:20:45 -0400
Date: Mon, 25 Oct 2004 17:20:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: Temporary NFS problem when rpciod is SIGKILLed
In-Reply-To: <200410251812.28663.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.53.0410251717320.19116@yvahk01.tjqt.qr>
References: <200410251702.58622.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.53.0410251622080.1778@yvahk01.tjqt.qr>
 <200410251812.28663.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>That's the point. It works in 2.4

Maybe because there is no rpciod in 2.4?

>Well, let's see. 2.4 works. rpciod in 2.6 shows this erratic behaviour
>even if I do "kill -9 <pid_of_rpciod>", thus no other process, kernel
>or userspace, know about this KILL.

Is rpciod (a kthread as I read from your 'ps' output) killable in 2.4 after
all?
Maybe the rpciod-26 is missing a sigblock()?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
