Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWH1UMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWH1UMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWH1UMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:12:22 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:7038 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751422AbWH1UMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:12:21 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=zUXjm560isQONUEOPUHPO5f2J81QKpoWEjf0W2EVYiKgLlxb3+4YnTKMHN9O76cMI+3smNaoqFSSS+iCuTNMKcY1+RebjITOCLiaV3KZVIUMhHqt+8rVYflY5wa16EyK;
X-IronPort-AV: i="4.08,176,1154926800"; 
   d="scan'208"; a="70404637:sNHT21196035"
Date: Mon, 28 Aug 2006 15:12:23 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Message-ID: <20060828201223.GE13464@lists.us.dell.com>
References: <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com> <44F29BCD.3080408@zytor.com> <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com> <44F335C8.7020108@zytor.com> <20060828184637.GD13464@lists.us.dell.com> <44F33D55.4080704@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F33D55.4080704@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 12:00:37PM -0700, H. Peter Anvin wrote:
> Matt Domsch wrote:
> >
> >No reason.  I was just trying to be careful, not leaving data in the
> >upper bits of those registers going uninitialized.  If we know they're
> >not being used ever, then it's not a problem.  But I don't think
> >that's the source of the command line size concern, is it?
> >
> 
> No, it's treating the command line as a fixed buffer, as opposed to a 
> null-terminated string.  This was always a bug, by the way.

OK, I'll look at fixing that, and using %esi throughout.

Thanks,
Matt


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
