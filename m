Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVHXQbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVHXQbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVHXQbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:31:20 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:49165 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751138AbVHXQbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:31:19 -0400
Date: Wed, 24 Aug 2005 12:31:04 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: =?iso-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with kernel image in a Prep Boot on PowerPC
Message-ID: <20050824163100.GD1100@tuxdriver.com>
Mail-Followup-To: =?iso-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>,
	linux-kernel@vger.kernel.org
References: <430C8CB5.1050501@latinsourcetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <430C8CB5.1050501@latinsourcetech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 12:05:25PM -0300, Márcio Oliveira wrote:

>   I think the kernel is pointing to the wrong root partiotion. In a x86 
> box, I can change the kernel root partition in the boot loader (root= 
> parameter) or using the "rdev" command. In my case, the IBM Power 
> doesn't have a boot loader (yaboot was replaced by the kernel image) and 
> the powerpc64 system doesn't have the rdev command (from util-linux 
> package, the same package on x86 systems have the rdev command!).

I don't know anything that will do this on a pre-built kernel.  But,
you should look at CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE in your
kernel configuration.  That will let you pre-configure the "root="
command line option.

I don't know if ppc64 can use the zImage-style boot wrapper.  If it
can, that would provide you with an option of modifying the command
line at boot time if needed.

Good luck!

John
-- 
John W. Linville
linville@tuxdriver.com
