Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272671AbTG1G50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272687AbTG1G5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:57:25 -0400
Received: from science.horizon.com ([192.35.100.1]:40754 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S272671AbTG1G5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:57:22 -0400
Date: 28 Jul 2003 07:12:36 -0000
Message-ID: <20030728071236.15338.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the term "obsolete" is a bit confusing to end-users.

When applied to a device driver, there are three separate definitions
that are at risk of being conflated:
- The hardware it supports is obsolete (EISA is obsolete)
- The code (which may still work) has been superseded by a new improved
  version (OSS is obsolete, Linus' original HD driver is obsolete)
- The code has not kept up with the kernel and no longer works with the
  current kernel.

The third category is what we're trying to identify here.

The risk of confusion is particularly large because often two of those
definitions apply at once.

If you want a suitably specific term for #3, I'd try CONFIG_BITROT.

I think that clearly conveys, in one word, "this code used to work, but
no longer does due to a lack of maintenance, and unless someone
breathes life back into it it will be given a decent burial."

(The other option that comes to mind is CONFIG_ORPHANED, which says
about the same thing, but might be unnecessarily insulting to a nominal
maintainer who hasn't been able to keep it up to date.  "Orphaned" implies
that nobody's trying.  "Bit rot" implies only a lack of *success*.)
