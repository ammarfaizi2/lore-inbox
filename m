Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423074AbWJYG76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423074AbWJYG76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 02:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423076AbWJYG76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 02:59:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9948 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423074AbWJYG76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 02:59:58 -0400
Subject: Re: What about make mergeconfig ?
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <1161755164.22582.60.camel@localhost.localdomain>
References: <1161755164.22582.60.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 07:59:59 +0100
Message-Id: <1161759599.27622.54.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 15:46 +1000, Benjamin Herrenschmidt wrote:
> 
> make mergeconfig <path_to_file>
> 
> That would merge all entries in the specified file with the
> current .config. By mergeing, that basically means that rule:
> 
> N + N = N
> m + N = m
> Y + N = Y
> m + Y = Y  

We have something vaguely similar in the Fedora package (I think it's
only in the CVS tree rather than in the SRPM itself, but the CVS tree is
public too).

http://cvs.fedora.redhat.com/viewcvs/*checkout*/rpms/kernel/devel/merge.pl?rev=1.9

It doesn't do quite what you asked for -- it works with 'incremental'
configuration. So any options specified in _any_ form in the second
config are overridden in the output. It lets us start with a generic
config, then apply options (turning stuff both on and off) for PowerPC
in general, and then for specific builds on top of that.

-- 
dwmw2

