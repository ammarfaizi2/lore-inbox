Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267884AbTGTTnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267981AbTGTTnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:43:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:21779 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S267884AbTGTTnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:43:08 -0400
Date: Sun, 20 Jul 2003 21:58:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Oliver Pitzeier <oliver@linux-kernel.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Makefile 'rpm' target on Red Hat (8.0/9)
Message-ID: <20030720195808.GA2323@mars.ravnborg.org>
Mail-Followup-To: Oliver Pitzeier <oliver@linux-kernel.at>,
	linux-kernel@vger.kernel.org
References: <200307201939.h6KJdqxs005419@indianer.linux-kernel.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307201939.h6KJdqxs005419@indianer.linux-kernel.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 09:40:23PM +0200, Oliver Pitzeier wrote:
> If 'rpmbuild' doesn't work on other rpm-based distributions (like the two above) I would recommend checking for /etc/redhat-release... Patch for Makefile (from kver 2.4.21-pre5) attached.

That looks horrible.

In 2.6-test1 the following code is used:
RPM             := $(shell if [ -x "/usr/bin/rpmbuild" ]; then echo rpmbuild; \
                        else echo rpm; fi)

I would suggest to do it this way, avoiding a distro specific check.
Also there is no reason to export the RPM variable

	Sam
