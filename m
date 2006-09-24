Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWIXWU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWIXWU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWIXWU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:20:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52176 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751264AbWIXWU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:20:27 -0400
Date: Sun, 24 Sep 2006 23:20:26 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Andrey Mirkin <amirkin@sw.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 18/28] kbuild: fail kernel compilation in case of unresolved module symbols
Message-ID: <20060924222026.GS29920@ftp.linux.org.uk>
References: <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159132706174-git-send-email-sam@ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 11:18:14PM +0200, sam@ravnborg.org wrote:
> From: Kirill Korotaev <dev@openvz.org>
> 
> At stage 2 modpost utility is used to check modules.  In case of unresolved
> symbols modpost only prints warning.
> 
> IMHO it is a good idea to fail compilation process in case of unresolved
> symbols (at least in modules coming with kernel), since usually such errors
> are left unnoticed, but kernel modules are broken.
> 
> - new option '-w' is added to modpost:
>   if option is specified, modpost only warns about unresolved symbols
> 
> - modpost is called with '-w' for external modules in Makefile.modpost

Oh, joy...  Could you add a way to tell kbuild that old behaviour is,
in fact, desired?  make MODPOST_FLAGS=-w or something along these lines...
