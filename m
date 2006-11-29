Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936094AbWK2UGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936094AbWK2UGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936093AbWK2UGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:06:22 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:3260 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S936094AbWK2UGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:06:21 -0500
Message-ID: <456DE85F.50806@cfl.rr.com>
Date: Wed, 29 Nov 2006 15:06:55 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Matt Garman <matthew.garman@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: What happened to CONFIG_TCP_NAGLE_OFF?
References: <bdd6985b0611281405j3e731e3xc7973c0365428663@mail.gmail.com>
In-Reply-To: <bdd6985b0611281405j3e731e3xc7973c0365428663@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Nov 2006 20:06:57.0455 (UTC) FILETIME=[EC38F3F0:01C713F1]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14844.000
X-TM-AS-Result: No--13.100100-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Garman wrote:
> I would like to globally disable nagling on my (2.6.9) system.  There
> are several references on the web to the CONFIG_TCP_NAGLE_OFF kernel
> config option.  However, it appears as though this no longer exists.
> 
> How might I achieve having TCP_NODELAY effectively set for all sockets
> (by default)?  Is there a new/different kernel config option, a patch,
> a sysctl or proc setting?  Or can I "fake" this behavior by, e.g.
> setting a send buffer sufficiently small?

This is a bad idea and breaks api compatibility.  Nagle is very 
important for sockets being used for things like telnet.  Other 
applications, like ftp, should already disable nagle themselves.

