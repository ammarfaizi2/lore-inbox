Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264223AbUEMOJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUEMOJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 10:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUEMOI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 10:08:29 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:10463 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264223AbUEMOGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 10:06:51 -0400
Date: Thu, 13 May 2004 15:05:01 +0100
From: Dave Jones <davej@redhat.com>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [tony@atomide.com: [PATCH] Powernow-k8 buggy BIOS override for 2.6.6]
Message-ID: <20040513140501.GG16687@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
	pavel@ucw.cz
References: <20040513001628.GA9388@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513001628.GA9388@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 05:16:28PM -0700, Tony Lindgren wrote:

 > Following is the updated patch to make the powernow-k8 driver work on 
 > machines with buggy BIOS, such as emachines m6805.
 > 
 > The patch overrides the PST table only if check_pst_table() fails.
 > 
 > The minimum value for the override is 800MHz, which is the lowest value 
 > on all x86_64 systems AFAIK. The max value is the current running value.
 > 
 > This patch should be safe to apply, even if Pavel's ACPI table check is
 > added to the driver. Or does anybody see a problem with it?

Does the ACPI fallback not do the right thing ?
I don't really see the point of limping along with a 2-state PST
if we can derive the proper info from the ACPI table.

		Dave

