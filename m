Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSBXRtG>; Sun, 24 Feb 2002 12:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290433AbSBXRsp>; Sun, 24 Feb 2002 12:48:45 -0500
Received: from courage.cs.stevens-tech.edu ([155.246.89.70]:15303 "HELO
	courage.cs.stevens-tech.edu") by vger.kernel.org with SMTP
	id <S290289AbSBXRsh>; Sun, 24 Feb 2002 12:48:37 -0500
Date: Sun, 24 Feb 2002 12:48:31 -0500 (EST)
From: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
To: <harish.vasudeva@amd.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Need some help with IP/TCP Checksum Offload
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F280E6@caexmta9.amd.com>
Message-ID: <Pine.NEB.4.33.0202241242060.9684-100000@courage.cs.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002 harish.vasudeva@amd.com wrote:

[...]
When does the OS/Protocol offload this task?

I can help with transport layer only -- checkumming  of the transport
protocol packet is done by transport protocol -- for instance see udp.c :
udp_getfrag (for sending). So you must came up with a nice design to do it
in hardware instead (ie. without messing with the transport layer too
much). Hope this helps, although there is obviously more to do on other
layers.

-marek

P.S. Please break your lines when you post.

