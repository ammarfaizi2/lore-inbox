Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUAaXVl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 18:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUAaXVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 18:21:41 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:55685 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265163AbUAaXVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 18:21:40 -0500
Date: Sat, 31 Jan 2004 23:19:18 +0000
From: Dave Jones <davej@redhat.com>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040131231918.GL20622@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
References: <20040131203512.GA21909@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131203512.GA21909@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 12:35:12PM -0800, Tony Lindgren wrote:
 > Hi all,
 > 
 > Following is a little patch to do a sanity check on the max speed and 
 > voltage values provided by the bios.
 > 
 > Some buggy bioses provide bad values if the cpu changes, for example, in 
 > my case the bios claims the max cpu speed is 1600MHz, while it's running at
 > 1800MHz. (Cheapo Emachines m6805 you know...) This could also happen on 
 > machines where the cpu is upgraded.
 > 
 > These checks should be safe, as they only change things if the machine is
 > already running at a higher speed than the bios claims.

ye gads, yet another problem with eMachines PST tables.
Conclusive proof I think that we need the 'read from ACPI P state tables
when PST contains garbage' patch.

		Dave

