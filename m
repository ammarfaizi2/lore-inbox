Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966257AbWKNSag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966257AbWKNSag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966261AbWKNSag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:30:36 -0500
Received: from mx1.suse.de ([195.135.220.2]:25524 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S966257AbWKNSaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:30:35 -0500
From: Andi Kleen <ak@suse.de>
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Subject: Re: [PATCH 0/2] Make the TSC safe to be used by gettimeofday().
Date: Tue, 14 Nov 2006 19:30:17 +0100
User-Agent: KMail/1.9.5
Cc: Shem Multinymous <multinymous@gmail.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Pavel Machek <pavel@suse.cz>
References: <455916A5.2030402@FreeBSD.org> <41840b750611140430k3b46023dr9a01b8b38bbb535d@mail.gmail.com> <4559F781.6020607@FreeBSD.org>
In-Reply-To: <4559F781.6020607@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141930.17860.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I have to admit that I didn't really design this patch with 
> suspend/resume in mind, and that I'm not too familiar with how they work.
> 
> Do the HPET/ACPI timers still run while the system is suspended?

No. In suspend to RAM only the RAM is still powered. On suspend to disk 
everything is off. But you can do every needed synchronization on resume.

-Andi
