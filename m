Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVFDFi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVFDFi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 01:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFDFi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 01:38:57 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:38696 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261229AbVFDFbn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 01:31:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZbJk5UfOagzNKfecQomL4PtgLQ2IbDeRLnKDbGgCZeU6pHJFLEQfoNMPnGBSKdi7jd0ZdoC7V0OjdMgYkyTDCPCfFyT4mdWX8Cm6f0q1gIyCY0qYgtvZdDQvj/IjADuLpzWns9phdhQk69KktPizuq+jEVHxS3Ta81nWFr6KB04=
Message-ID: <21d7e9970506032231390a9fe6@mail.gmail.com>
Date: Sat, 4 Jun 2005 15:31:43 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Meelis Roos <mroos@linux.ee>
Subject: Re: Disabling IRQ #11 - uhci || e100 || r128-dri problem
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOC.4.61.0506021906200.11783@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.SOC.4.61.0506021906200.11783@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In recent 2.6.12 prereleases a bug has appeared. Whenever I log out of
> KDE, IRQ 11 is disabled on X server restart (kdm restarts it). It always
> results with the dmesg below and sometimes the new X loses keyboard
> input (ps2 keyboard, usb mouse). USB mouse works well. X works (sans
> keyboard sometimes). Network is dead.

It looks like X or something is causing the r128 to emit an IRQ after
we've stopped listening for them,...

Can you see if you get any info with drm debug on?

echo 1 > /sys/modules/drm/parameters/debug
and restart X...
Dave.
