Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUGFWxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUGFWxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUGFWxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:53:16 -0400
Received: from holomorphy.com ([207.189.100.168]:61145 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264652AbUGFWxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:53:05 -0400
Date: Tue, 6 Jul 2004 15:52:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-ID: <20040706225255.GU21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <20040706153417.237e454e.akpm@osdl.org> <20040706154555.79673f14.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706154555.79673f14.davem@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>> Third, some naive check for undefined symbols failed to understand the
>>> relocation types indicating that a given operand refers to some hard
>>> register, which manifest as undefined symbols in ELF executables. A
>>> patch to refine its criteria, which I used to build with, follows. rmk
>>> and hpa have some other ideas on this undefined symbol issue I've not
>>> quite had the opportunity to get a clear statement of yet.

On Tue, 6 Jul 2004 15:34:17 -0700 Andrew Morton <akpm@osdl.org> wrote:
> > I converted that to a non-fatal warning due to the same problem on sparc64.

On Tue, Jul 06, 2004 at 03:45:55PM -0700, David S. Miller wrote:
> Andrew, Russell posted to us in private email an objdump based
> check that didn't trigger for the register declaration case.

He seems not to have cc:'d me. Apparently *UND* isn't always the fourth
field so he did objdump --syms vmlinux | grep '^[^R][^E][^G].*\*UND\*'
instead of the awk expression I brewed up.


-- wli
