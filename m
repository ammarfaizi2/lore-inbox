Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293213AbSCAPiK>; Fri, 1 Mar 2002 10:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293251AbSCAPhx>; Fri, 1 Mar 2002 10:37:53 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:23025 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293213AbSCAPhp>; Fri, 1 Mar 2002 10:37:45 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020301.073328.124865821.davem@redhat.com> 
In-Reply-To: <20020301.073328.124865821.davem@redhat.com>  <Pine.LNX.4.33.0202280854250.15607-100000@home.transmeta.com> <22820.1014996781@redhat.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: recalc_sigpending() / recalc_sigpending_tsk() ? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Mar 2002 15:37:41 +0000
Message-ID: <23330.1014997061@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
>  Add a space to the definition, ala "recalc_sigpending (current)" so
> that CPP expands the module version properly.

$ grep recalc_sigpending background.i 
#define __ver_recalc_sigpending _ver_str(6682695c)
#define recalc_sigpending _set_ver(recalc_sigpending)
static inline void recalc_sigpending_Rsmp_6682695c(struct task_struct *t)
#define recalc_sigpending() recalc_sigpending (current)
                recalc_sigpending (get_current());
                recalc_sigpending (get_current());


--
dwmw2


