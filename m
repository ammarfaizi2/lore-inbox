Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263243AbTCNECj>; Thu, 13 Mar 2003 23:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbTCNECj>; Thu, 13 Mar 2003 23:02:39 -0500
Received: from holomorphy.com ([66.224.33.161]:64968 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263243AbTCNECh>;
	Thu, 13 Mar 2003 23:02:37 -0500
Date: Thu, 13 Mar 2003 20:13:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 instability on bigmem systems?
Message-ID: <20030314041307.GK20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Gregory K. Ruiz-Ade" <gregory@castandcrew.com>,
	linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com> <200303131745.28683.gregory@castandcrew.com> <20030314015346.GJ20188@holomorphy.com> <200303131955.27060.gregory@castandcrew.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303131955.27060.gregory@castandcrew.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 07:55:27PM -0800, Gregory K. Ruiz-Ade wrote:
> I got an opportunity, so the contents of cpuinfo, slabinfo, and meminfo are 
> at: http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.20
> Hopefully they're useful.
> Additionally, I managed to generate an Oops (processed with ksymoops, too) 
> while trying to create an LVM snapshot.  The oops and it's 
> ksymoops-translated file are up there too.  The oops traces back into the 
> VM somewhere.

Hmm, neither slabinfo nor meminfo show the machine being under any stress.
Were they generated while the problem was happening?

The useful information would be to collect meminfo and slabinfo while
kswapd and updated are spinning. Also, cpuinfo doesn't ever change,
(at least while being run on the same box) so you can leave that out.

BTW, oopses tracing back into the VM doesn't help. It's usually someone
doing something wrong the VM checks for. In this case I'll bet someone
(i.e. LVM) called vmalloc() with interrupts off.


-- wli
