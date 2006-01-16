Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWAPJ3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWAPJ3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWAPJ25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:28:57 -0500
Received: from outmx026.isp.belgacom.be ([195.238.4.91]:65236 "EHLO
	outmx026.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932298AbWAPJ2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:28:23 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] screen remains blank after LID switch use
User-Agent: KMail/1.9.1
References: <200601160946.51765.lkml@kcore.org> <43CB60E4.1060305@sairyx.org>
In-Reply-To: <43CB60E4.1060305@sairyx.org>
MIME-Version: 1.0
Content-Disposition: inline
Date: Mon, 16 Jan 2006 10:28:03 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601161028.04137.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 10:01, Arlen Christian Mart Cuss wrote:
> Check out /proc/acpi - you should find a few things that you can tinker
> with, including one for your screen; often called `lcd'. If you "echo 1
>
>  > lcd" in the right directory, it should switch it on. "echo 0 > lcd"
>
> switches it off. Whatever is managing your power that turns it off,
> isn't turning it back on. Look into these. It's not likely to be the
> console/X driver's fault.

Okay, thanks for that information. After some further googling I came up with 
this:

# echo 0x80000001 > /proc/acpi/video/VID/LCD/state

and the screen comes back to life. Thanks!

Jan

-- 
To err is human, to forgive is against company policy.
