Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVFUFsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVFUFsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVFUFpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 01:45:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261414AbVFTWku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:40:50 -0400
Date: Mon, 20 Jun 2005 18:40:39 -0400
From: Dave Jones <davej@redhat.com>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two agpgart probes at boot.
Message-ID: <20050620224039.GA3990@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
References: <200506171943.40592.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506171943.40592.nick@linicks.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 07:43:40PM +0100, Nick Warne wrote:
 > Hi all,
 > 
 > Can anybody point me in the direction of why I get 'what appears' to be two 
 > agpgart probes on boot (2.6.11.12 on updated Slack 10):
 > 
 > Jun 17 18:40:27 linuxamd kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
 > Jun 17 18:40:27 linuxamd kernel: agpgart: Putting AGP V2 device at  0000:00:00.0 into 4x mode
 > Jun 17 18:40:27 linuxamd kernel: agpgart: Putting AGP V2 device at  0000:01:00.0 into 4x mode
 > Jun 17 18:40:27 linuxamd kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
 > Jun 17 18:40:27 linuxamd kernel: agpgart: Putting AGP V2 device at  0000:00:00.0 into 4x mode
 > Jun 17 18:40:27 linuxamd kernel: agpgart: Putting AGP V2 device at  0000:01:00.0 into 4x mode

These messages aren't probing messages per se. They happen when something
(typically X) opens /dev/agpgart and sets up dri. It'll get logged
every time that X gets restarted.  That there are two of them with the
same datestamp is odd though. For some reason your X did this twice.

		Dave

