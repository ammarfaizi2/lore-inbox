Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263200AbTCSVGH>; Wed, 19 Mar 2003 16:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263201AbTCSVGH>; Wed, 19 Mar 2003 16:06:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6159 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263200AbTCSVGG>;
	Wed, 19 Mar 2003 16:06:06 -0500
Date: Wed, 19 Mar 2003 22:17:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.65-mjb1: lkcd: EXTRA_TARGETS is obsolete
Message-ID: <20030319211704.GA1030@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <8230000.1047975763@[10.10.2.4]> <20030319153304.GC23258@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319153304.GC23258@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 04:33:04PM +0100, Adrian Bunk wrote:
> 
> EXTRA_TARGETS is obsolete in 2.5.
> 
> The following should do the same:
> 
> +obj-$(CONFIG_CRASH_DUMP)	+= kerntypes.o

As Andrew pointed out this is wrong.
Use the following notation:
+extra-$(CONFIG_CRASH_DUMP)	+= kerntypes.o

This way of selecting extra .o files is the reason to have the "-y"
in extra-y.

	Sam
