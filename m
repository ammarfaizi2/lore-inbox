Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUITLEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUITLEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUITLEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:04:44 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:35269 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S266243AbUITLEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:04:20 -0400
Date: Mon, 20 Sep 2004 13:06:31 +0200
From: DervishD <lkml@dervishd.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920110631.GJ5482@DervishD>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-PopBeforeSMTPSenders: raul@dervishd.net
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Andries :)

 * Andries.Brouwer@cwi.nl <Andries.Brouwer@cwi.nl> dixit:
> If we would put the mount options in /proc/mounts, and introduced
> a comment convention (say, the part starting with \: is ignored by
> the kernel but can be used by programs reading /proc/mounts),
> then /etc/mtab can die. Comments? Better solutions?

    If you add a comment convention to /proc/mounts so you can use it
as a substitute for /etc/mtab, you will probably break the apps that
use /etc/mtab. I was wondering, then... does the kernel *read*
/proc/mounts contents? If the answer is no, then you can add all
syntactic noise you want to /proc/mounts, exporting options needed
for userspace programs, with no problem. You can make /proc/mounts to
look like /etc/mtab. That will solve most of the problems.

    If the kernel needs to read /proc/mounts, then you have a
problem: you will need /etc/mtab as long as you have to use loop
devices, user mounts, etc.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
