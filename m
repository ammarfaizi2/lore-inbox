Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTKSGTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 01:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTKSGTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 01:19:20 -0500
Received: from holomorphy.com ([199.26.172.102]:33704 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263824AbTKSGTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 01:19:19 -0500
Date: Tue, 18 Nov 2003 22:19:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: use ELF sections for get_wchan()
Message-ID: <20031119061917.GN22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031118074448.GD19856@holomorphy.com> <20031118084336.A28004@flint.arm.linux.org.uk> <20031118084529.GK22764@holomorphy.com> <20031118085022.GL22764@holomorphy.com> <20031119031337.GM22764@holomorphy.com> <20031119055332.GA934@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119055332.GA934@mars.ravnborg.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 07:13:37PM -0800, William Lee Irwin III wrote:
>> willy said I should use .sched.text instead of .text.sched; this fixes
>> it up to do that.

On Wed, Nov 19, 2003 at 06:53:32AM +0100, Sam Ravnborg wrote:
> Hi wli,
> how about utilising asm-generic/vmlinux.h.S now that you are touching so
> many .lds files?
> Something like the attached could be used?
> That will simplify and consolidate the the .lds files, but full
> flexibility remains.
> I noticed that there were small diferences between the individual
> architectures, but specifying only content of the section should allow
> it to be used all over.

This doesn't quite cover all cases, though I agree in principle. It
would probably be okay to rearrange the sections, but I'm vaguely
queasy about it turning into a cleanup.


-- wli
