Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270851AbTGPOIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270852AbTGPOIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:08:17 -0400
Received: from dsl093-172-017.pit1.dsl.speakeasy.net ([66.93.172.17]:52883
	"EHLO nevyn.them.org") by vger.kernel.org with ESMTP
	id S270851AbTGPOH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:07:57 -0400
Date: Wed, 16 Jul 2003 10:22:49 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SUID root
Message-ID: <20030716142249.GA22473@nevyn.them.org>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307161017060.26254@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307161017060.26254@chaos>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 10:19:14AM -0400, Richard B. Johnson wrote:
> 
> It appears as though SUID root programs don't work on
> linux 2.4.20, 2.4.21, or 2.4.22-pre6, or at least what
> used to work no longer does.
> 
> One program tries to execute iopl(3). In the event that
> it fails, it tries to set UID/GID to root after saving
> the previous, then tries again.
> 
> The program exists in /usr/bin, properly owned by root. It
> is set SUID, 4755, and otherwise works. Anybody have any
> clues? Do SUID programs have to be re-written to use some
> other mechanism? I need to have a user-mode program get
> access to an otherwise unused printer port. It's a shame
> to write a module just for this.

You're stracing it.  Stracing prevents setuid from occurring; it used
to just prevent the exec.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
