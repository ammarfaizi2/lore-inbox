Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWEVMlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWEVMlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWEVMlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:41:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34190 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750799AbWEVMlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:41:21 -0400
Date: Mon, 22 May 2006 08:41:02 -0400
From: Dave Jones <davej@redhat.com>
To: dragoran <dragoran@feuerpokemon.de>
Cc: Andi Kleen <ak@suse.de>, Ulrich Drepper <drepper@gmail.com>,
       Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-ID: <20060522124102.GB3486@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	dragoran <dragoran@feuerpokemon.de>, Andi Kleen <ak@suse.de>,
	Ulrich Drepper <drepper@gmail.com>, Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org
References: <44702650.30507@feuerpokemon.de> <200605220019.08902.ak@suse.de> <20060521222831.GP8250@redhat.com> <200605220037.58286.ak@suse.de> <20060521234821.GQ8250@redhat.com> <4471533C.2030605@feuerpokemon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4471533C.2030605@feuerpokemon.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 07:59:24AM +0200, dragoran wrote:

 > >If a regular user can trip up debugging printks, yes, lets remove it.
 > >Examples ?
 > >
 > allmost all selinux messages.

I assume you mean AVC messages ? They indicate something that should be
fixed in selinux policy (or that your filesystem is incorrectly labelled
-- such as if you've booted with selinux=0 at any point).

They can also get filtered with the audit subsystem to /var/log/audit/, never
hitting the dmesg ringbuffer.

		Dave

-- 
http://www.codemonkey.org.uk
