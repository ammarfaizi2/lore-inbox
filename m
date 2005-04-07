Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVDGRh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVDGRh1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVDGRh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:37:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262530AbVDGRhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:37:21 -0400
Date: Thu, 7 Apr 2005 13:37:13 -0400
From: Dave Jones <davej@redhat.com>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Magnus Damm <magnus.damm@gmail.com>,
       roland@topspin.com, asterixthegaul@gmail.com, damm@opensource.se,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Message-ID: <20050407173713.GD17485@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Richard B. Johnson" <linux-os@analogic.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Magnus Damm <magnus.damm@gmail.com>, roland@topspin.com,
	asterixthegaul@gmail.com, damm@opensource.se,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20050407100147.7b91a2d2.rddunlap@osdl.org> <Pine.LNX.4.61.0504071319430.5977@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504071319430.5977@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 01:22:57PM -0400, Richard B. Johnson wrote:

 > >| Anyway, besides nitpicking, is there any reason not to include this
 > >| code? Or is the added feature considered plain bloat? Yes, the kernel
 > >| will become a bit larger, but all the data added by this patch will go
 > >| into the init section.
 > >
 > >Looks like a good idea to me.
 > >
 > Can't you disable module-loading with a module? I think so.
 > You don't need to modify the kernel. Boot-scripts could
 > just load the "final" module and there is nothing that
 > can be done to add another module (or even unload existing
 > ones).

Why do you need a module ?

echo 0xFFFEFFFF ?> /proc/sys/kernel/cap-bound

should do this just fine.

		Dave
