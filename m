Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291210AbSBLWLB>; Tue, 12 Feb 2002 17:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291213AbSBLWKx>; Tue, 12 Feb 2002 17:10:53 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:14333 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S291210AbSBLWKr>; Tue, 12 Feb 2002 17:10:47 -0500
Date: Wed, 13 Feb 2002 00:10:26 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Bill Davidsen <davidsen@tmr.com>, Padraig Brady <padraig@antefacto.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020212221025.GH1105@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Bill Davidsen <davidsen@tmr.com>,
	Padraig Brady <padraig@antefacto.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C695035.6040902@antefacto.com> <Pine.LNX.3.96.1020212132711.6082B-100000@gatekeeper.tmr.com> <20020212140624.R9826@lynx.turbolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020212140624.R9826@lynx.turbolabs.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 02:06:24PM -0700, you [Andreas Dilger] wrote:
> 
> You can also extract it from an uncompressed kernel (vmlinux) or the
> module with "strings <file> | grep '[A-Z]*=[ym]$'".  It is simple
> enough to search for the gzip magic (1f 8b 08 00 at about 16-18kB)
> in a zImage or bzImage, and then pipe it to gunzip and strings as above.

Such script could live in /usr/src/linux/scripts. The same script could
perhaps extract the version string as well. Anybody got a clue how to find
it reliably? Is this reliable 

strings /boot/bzImage |
 egrep '^[0-9]+\.[0-9]\.+.*\(.*@.*\).*[0-9]+:[0-9]+:[0-9]+' | 
 head -1


-- v --

v@iki.fi
