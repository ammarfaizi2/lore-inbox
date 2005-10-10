Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVJJVgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVJJVgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJJVgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:36:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21128 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751266AbVJJVgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:36:16 -0400
Date: Mon, 10 Oct 2005 23:36:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/16] GFS: headers
Message-ID: <20051010213607.GA2475@elf.ucw.cz>
References: <20051010170948.GB22483@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010170948.GB22483@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> +#ifdef WANT_GFS2_CONVERSION_FUNCTIONS
> +
> +#define CPIN_08(s1, s2, member, count) {memcpy((s1->member), (s2->member), (count));}
> +#define CPOUT_08(s1, s2, member, count) {memcpy((s2->member), (s1->member), (count));}
> +#define CPIN_16(s1, s2, member) {(s1->member) = le16_to_cpu((s2->member));}
> +#define CPOUT_16(s1, s2, member) {(s2->member) = cpu_to_le16((s1->member));}
> +#define CPIN_32(s1, s2, member) {(s1->member) = le32_to_cpu((s2->member));}
> +#define CPOUT_32(s1, s2, member) {(s2->member) = cpu_to_le32((s1->member));}
> +#define CPIN_64(s1, s2, member) {(s1->member) = le64_to_cpu((s2->member));}
> +#define CPOUT_64(s1, s2, member) {(s2->member) = cpu_to_le64((s1->member));}
> +
> +#define pv(struct, member, fmt) printk("  "#member" = "fmt"\n", struct->member);
> +#define pa(struct, member, count) print_array(#member, struct->member, count);

Nice way to obfuscate code, I'd say. Can you just inline those macros?
This is very hard to read...
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
