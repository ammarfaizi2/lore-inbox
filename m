Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVAKCaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVAKCaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVAKCaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:30:39 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:36620 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262538AbVAKCaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:30:07 -0500
Date: Tue, 11 Jan 2005 03:30:03 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alex LIU <alex.liu@st.com>, linux-kernel@vger.kernel.org
Subject: Re: The purpose of PT_TRACESYSGOOD
Message-ID: <20050111023003.GA2760@pclin040.win.tue.nl>
References: <005c01c4f6c8$b4d3fba0$ac655e0a@sha.st.com> <20050110202427.GA1358@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110202427.GA1358@elf.ucw.cz>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: SINECTIS: pastinakel.tue.nl 1114; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> What's the effect of PT_TRACESYSGOOD flag? I found it's used only set
>> in ptrace_setoptions, which is called in the function
>> ptrace_request. And the PT_TRACESYSGOOD flag will be requested in
>> do_syscall_trace. What's the purpose of that flag?


/*
 * A child stopped at a syscall has status as if it received SIGTRAP.
 * In order to distinguish between SIGTRAP and syscall, some kernel
 * versions have the PTRACE_O_TRACESYSGOOD option, that sets an extra
 * bit 0x80 in the syscall case.
 */
