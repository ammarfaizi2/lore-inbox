Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTJCX64 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbTJCX6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:58:55 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:43554 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261595AbTJCX6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:58:42 -0400
Date: Sat, 4 Oct 2003 00:58:02 +0100
From: Dave Jones <davej@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FDC motor left on
Message-ID: <20031003235801.GA5183@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0310031322430.499@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0310031322430.499@chaos>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 01:25:30PM -0400, Richard B. Johnson wrote:
 > In linux-2.4.22 and earlier, if there is no FDC driver installed,
 > the FDC motor may continue to run after boot if the motor was
 > started as part of the BIOS boot sequence.
 > This patch turns OFF the motor once Linux gets control.
 > 
 > 
 > --- linux-2.4.22/arch/i386/boot/setup.S.orig	Fri Aug  2 20:39:42 2002
 > +++ linux-2.4.22/arch/i386/boot/setup.S	Fri Oct  3 11:50:43 2003
 > @@ -59,6 +59,8 @@

Does this mean the 'kill_motor' function in bootsect.S isn't doing
what it should be? If so, maybe that needs fixing instead of turning
it off in two places ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
