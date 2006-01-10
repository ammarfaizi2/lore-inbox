Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWAJNRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWAJNRF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWAJNRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:17:04 -0500
Received: from webapps.arcom.com ([194.200.159.168]:13829 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S932208AbWAJNRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:17:03 -0500
Message-ID: <43C3B3C3.6080204@cantab.net>
Date: Tue, 10 Jan 2006 13:16:51 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Dahlmann <thomas.dahlmann@amd.com>
CC: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       Jordan Crouse <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: [linux-usb-devel] [PATCH] UDC support for MIPS/AU1200 and Geode/CS5536
References: <20060109180356.GA8855@cosmic.amd.com> <200601092344.55988.oliver@neukum.org> <43C39431.6020308@amd.com>
In-Reply-To: <43C39431.6020308@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jan 2006 13:20:42.0578 (UTC) FILETIME=[A83CA320:01C615E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Dahlmann wrote:
> 
> The loop is for reading dwords only, so "i < bytes / UDC_DWORD_BYTES" cuts
> off remaining 1,2 or 3 bytes which are handled by the next loop.
> But you are right, incrementing by 4 may look better,  as
> 
>        for (i = 0; i < bytes - bytes % UDC_DWORD_BYTES; i+=4) {

    for (i = 0; i <= bytes - UDC_DWORD_BYTES; i += 4) {

?

David Vrabel
