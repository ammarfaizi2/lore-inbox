Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262199AbTC1Fln>; Fri, 28 Mar 2003 00:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbTC1Fln>; Fri, 28 Mar 2003 00:41:43 -0500
Received: from holomorphy.com ([66.224.33.161]:4526 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262199AbTC1Flm>;
	Fri, 28 Mar 2003 00:41:42 -0500
Date: Thu, 27 Mar 2003 21:52:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q before pgcl
Message-ID: <20030328055233.GO30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20030328040036.GA13178@holomorphy.com> <Pine.LNX.4.10.10303272136540.25072-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10303272136540.25072-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 09:37:13PM -0800, Andre Hedrick wrote:
> Where is the IDE/ATA in the system?
> Andre Hedrick
> LAD Storage Consulting Group

The chipset includes some kind of IDE support but there's no way to
physically connect to the built-in controller. In principle one could
get a PCI IDE HBA and plug it in, but I am skeptical of the wisdom of
blocking buses on large SMP systems. More modern revisions of ATA could
prove useful, but this 5-year-old hunk of junk isn't going to get
decked out with any useful number of devices before it gets melted down.

This thing is basically stripped of io on several levels, in no small
part b/c arch/i386/ can't handle the number of interrupt sources etc.,
in part b/c PCI fixups I don't have docs (anymore) on how to do aren't
being done, and in part because other ppl are supposed to be doing io.
The only reason I've even got an aic7xxx is because qlogicisp.c is
fscked beyond the ability of anyone's knowledge of the hardware to
repair and it was blocking real programming tasks etc.


-- wli
