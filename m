Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWGJMqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWGJMqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWGJMqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:46:40 -0400
Received: from gherkin.frus.com ([192.158.254.49]:50698 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1161004AbWGJMqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:46:39 -0400
Subject: Re: 2.6.18-rc1 build error (YACC): followup
In-Reply-To: <44B14AEB.2060902@zytor.com> "from H. Peter Anvin at Jul 9, 2006
 11:28:59 am"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 10 Jul 2006 07:46:37 -0500 (CDT)
CC: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060710124637.A36C5DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Sam Ravnborg wrote:
> > On Fri, Jul 07, 2006 at 04:54:34PM -0700, H. Peter Anvin wrote:
> >> I propose the following as a global yacc rule; already used in usr/dash 
> >> in the klibc tree, and which seems to work for both bison and BSD yacc:
> >>
> >> quiet_cmd_yacc = YACC    $@
> >>       cmd_yacc = $(YACC) -d -o $@ $<
> >>
> >> $(obj)/%.c %(obj)/%.h: $(src)/%.y
> >>         $(call cmd,yacc)
> > klibc and the kernel does not share any rules today.
> > And yacc is so special that it's not worth it only for yacc to start
> > doing this.
> > 
> > In todays kernel build yacc is never used. For the few cases were output
> > of yacc is needed the kernel include _shipped files. For dash we should
> > maybe consider the same?
> > 
> 
> Personally I consider that pretty silly.  yacc/bison is a standard, 
> portable utility, and it isn't even architecture-dependent so there is 
> no porting effort.

While the correct fix is being contemplated, LEX also needs defining in
the same aic7xxx/aicasm Makefile context.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
