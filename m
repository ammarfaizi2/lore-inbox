Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUJDMCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUJDMCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUJDMCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:02:40 -0400
Received: from iPass.cambridge.arm.com ([193.131.176.58]:36844 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S268058AbUJDMCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:02:16 -0400
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
References: <20040927210305.A26680@flint.arm.linux.org.uk>
	<20041001211106.F30122@flint.arm.linux.org.uk>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 04 Oct 2004 13:01:52 +0100
In-Reply-To: <20041001211106.F30122@flint.arm.linux.org.uk> (Russell King's
 message of "Fri, 1 Oct 2004 21:11:06 +0100")
Message-ID: <tnxllemvgi7.fsf@arm.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

Russell King <rmk+lkml@arm.linux.org.uk> writes:
> + * This ignores the intensely annoying "mapping symbols" found
> + * in ARM ELF files: $a, $t and $d.
> + */
> +static inline int is_arm_mapping_symbol(const char *str)
> +{
> +	return str[0] == '$' && strchr("atd", str[1]) && str[2] == '\0';

str[2] can be '\0' or '.', since a mapping symbol can also be
$[atd].<any> (because binutils doesn't like to generate duplicate
local labels).

Catalin

