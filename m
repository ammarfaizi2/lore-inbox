Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVEWS3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVEWS3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 14:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVEWS3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 14:29:05 -0400
Received: from a.relay.invitel.net ([62.77.203.3]:46481 "EHLO
	a.relay.invitel.net") by vger.kernel.org with ESMTP id S261756AbVEWS3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 14:29:01 -0400
Date: Mon, 23 May 2005 20:28:56 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
Message-ID: <20050523182856.GC20318@vega.lgb.hu>
Reply-To: lgb@lgb.hu
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com> <Pine.LNX.4.58.0505201259560.2206@ppc970.osdl.org> <Pine.LNX.4.61.0505201612360.6833@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0505201612360.6833@chaos.analogic.com>
X-Operating-System: vega Linux 2.6.10-5-686 i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, May 20, 2005 at 04:17:43PM -0400, Richard B. Johnson wrote:
> Well I started out opening /dev/vcs, lseeking to 64, and writing
> a string. This "sort of" worked, but screen attributes got messed
> up so the "blue" screen attribute 0x17 ended up eventually being
> black.

/dev/vcsa != /dev/vcs !!!!

There are two different devices, as far as I remember, one is only for
the characters itself on the console, and one includes attributes as well ...

FYI Documentation/devices.txt:

0 = /dev/vcs          Current vc text contents
                  1 = /dev/vcs1         tty1 text contents
[...]
                128 = /dev/vcsa         Current vc text/attribute contents
                129 = /dev/vcsa1        tty1 text/attribute contents

 
- Gábor
