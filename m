Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbUKRFVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbUKRFVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 00:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbUKRFVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 00:21:04 -0500
Received: from mail.suse.de ([195.135.220.2]:60072 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262570AbUKRFUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 00:20:55 -0500
Date: Thu, 18 Nov 2004 06:06:24 +0100
From: Andi Kleen <ak@suse.de>
To: kernel-stuff@comcast.net
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: X86_64: Many Lost ticks
Message-ID: <20041118050624.GB1478@wotan.suse.de>
References: <111820040402.18259.419C1EEE000EC75D00004753220075115000009A9B9CD3040A029D0A05@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111820040402.18259.419C1EEE000EC75D00004753220075115000009A9B9CD3040A029D0A05@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 04:02:55AM +0000, kernel-stuff@comcast.net wrote:
> I have a X86_64 laptop (Compaq Presario R3240) with all BIOS updates in place. I routinely get the "Warning : many lost ticks" message in dmesg. 

Known problem.  ACPI uses a broken way to access the EC register,
and VIA chipsets take extremly long for this operation.  This
happens regularly to read the system temperature.
A fix is currently being discussed. 

-Andi
