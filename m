Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTIHKI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 06:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTIHKI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 06:08:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:53124 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262182AbTIHKIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 06:08:25 -0400
Date: Mon, 8 Sep 2003 11:07:21 +0100
From: Dave Jones <davej@redhat.com>
To: Chris Peterson <chris@potamus.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: blank boot screen on linux-2.6.0-test4 (with workaround)
Message-ID: <20030908100721.GF28927@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Peterson <chris@potamus.org>, linux-kernel@vger.kernel.org
References: <001d01c375d5$be456a90$323be90c@bananacabana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01c375d5$be456a90$323be90c@bananacabana>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 11:52:17PM -0700, Chris Peterson wrote:
 > As Charles suggested, here are my .config files for my linux-2.4.20-8
 > (Redhat 9) and linux-2.6.0-test4 builds. CONFIG_FB_VESA is enabled for 2.6,
 > but vga=773 still does not work (and video=vga16:off is still needed, unlike
 > 2.4). I am using a Dell Latitude C400 laptop, which uses an Intel i810 video
 > card, which only recently been supported by Redhat 9 and XFree86.
 > 
 > I've also tried Redhat's arjanv's linux-2.6 RPMs, which include the
 > following known problems for the AGP modules. The AGP problem definitely
 > affects my laptop because I just "modprobe intel-agp" before startx will
 > work. Could this same AGP problem be causing my vga=773 problems?

No. vesafb should be fine. i810fb may have interactions with agpgart,
but you can't load that without intel-agp anyway, so thats not your
problem.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
