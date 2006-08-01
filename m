Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWHAMJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWHAMJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 08:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWHAMJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 08:09:39 -0400
Received: from web25813.mail.ukl.yahoo.com ([217.146.176.246]:1649 "HELO
	web25813.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751154AbWHAMJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 08:09:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type;
  b=IoXhHV+qvQnDz+g5PsZzp5EePRRdK6Ylx6CMxqAhnFQiUUN79UJuL9/loWC0pC8mISM+fk1fn+JhsCOntp+hHJge8Wa1h01A/GZIYk3XGcj8PidD/vQOa/Tgzg/NbizpBBisW7MyGSu03mj3sFdR3Vm4kWVw1BRD9W763TvBtQc=  ;
Message-ID: <20060801120937.69641.qmail@web25813.mail.ukl.yahoo.com>
Date: Tue, 1 Aug 2006 12:09:37 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [HW_RNG] How to use generic rng in kernel space
To: mb@bu3sch.de
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I developped a HW RNG for a custom board and several
other drivers are using it through a special entry I made.
I was planning to move the code in order to use the generic
the RNG layer but I encounter an issue.

Currently it seems not possible for a driver to use HW RNG,
because there's no entry point for that. Is that something
deliberate ?

Another question about the implementation. If O_NONBLOCK
flag is passed when opening /dev/hw_random, how does the
read method ensure that the caller won't sleep since it calls
mutex_lock_interruptible() function unconditiannaly ? I must
miss something but don't know what...

Thanks

Francis



