Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030508AbWGINjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbWGINjE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 09:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbWGINjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 09:39:03 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:35513 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030508AbWGINjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 09:39:02 -0400
Date: Sun, 9 Jul 2006 15:38:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1 build error (YACC): followup
Message-ID: <20060709133844.GA6650@mars.ravnborg.org>
References: <20060707202442.DA2AFDBA1@gherkin.frus.com> <20060707223650.GB28811@mars.ravnborg.org> <44AEF43A.5020308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AEF43A.5020308@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 04:54:34PM -0700, H. Peter Anvin wrote:
> I propose the following as a global yacc rule; already used in usr/dash 
> in the klibc tree, and which seems to work for both bison and BSD yacc:
> 
> quiet_cmd_yacc = YACC    $@
>       cmd_yacc = $(YACC) -d -o $@ $<
> 
> $(obj)/%.c %(obj)/%.h: $(src)/%.y
>         $(call cmd,yacc)
klibc and the kernel does not share any rules today.
And yacc is so special that it's not worth it only for yacc to start
doing this.

In todays kernel build yacc is never used. For the few cases were output
of yacc is needed the kernel include _shipped files. For dash we should
maybe consider the same?

	Sam
