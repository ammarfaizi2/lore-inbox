Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWH1Sqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWH1Sqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWH1Sqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:46:37 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:55821 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1751328AbWH1Sqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:46:36 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=tpwF/c1mDDqQNOKk0M/iZ1Ntotu7kQdWFS/Xti5DZqCTndXjL308De4HLPM4AK18BOF9DKplckIxzsNyPd7YGw+oasB8x5crzY6MmO5bXgqq6uHx6KAFc6A6SlbGT9c7;
X-IronPort-AV: i="4.08,176,1154926800"; 
   d="scan'208"; a="70359577:sNHT2672311239"
Date: Mon, 28 Aug 2006 13:46:37 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Message-ID: <20060828184637.GD13464@lists.us.dell.com>
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de> <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com> <44F29BCD.3080408@zytor.com> <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com> <44F335C8.7020108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F335C8.7020108@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 11:28:24AM -0700, H. Peter Anvin wrote:
> Alon Bar-Lev wrote:
> >On 8/28/06, H. Peter Anvin <hpa@zytor.com> wrote:
> >>Totally pointless since we're in 16-bit mode (as is the "incl %esi")...
> >>I guess it's "better" in the sense that if we run out of that we'll
> >>crash due to a segment overrun... maybe (some BIOSes leave us
> >>unknowningly in big real mode...)
> >
> >So leave as is? Loading address into esi and reference as si?
> >Or modify the whole code to use 16 bits?
> >
> 
> Probably modifying the whole code to use 16 bits, unless there is a 
> specific reason not to (Matt?)

No reason.  I was just trying to be careful, not leaving data in the
upper bits of those registers going uninitialized.  If we know they're
not being used ever, then it's not a problem.  But I don't think
that's the source of the command line size concern, is it?

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
