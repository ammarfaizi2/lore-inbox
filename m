Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbULJQZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbULJQZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbULJQZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:25:49 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:985 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261217AbULJQZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:25:46 -0500
Subject: Re: IDE: strange WAIT_READY dependency on APM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041209034438.GF22324@stusta.de>
References: <20041209034438.GF22324@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102692003.3201.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Dec 2004 15:20:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-09 at 03:44, Adrian Bunk wrote:
> The time for the !APM case was already increased from 30msec in 2.4 .
> Isn't there a timeout that is suitable for all cases?

The five seconds should be just fine for all cases. The smaller value
with no
power manglement should help speed up recovery however. It probably
doesn't belong CONFIG_APM now ACPI and friends are involved either.

