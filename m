Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWDYExj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWDYExj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 00:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWDYExj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 00:53:39 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:38635 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751368AbWDYExi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 00:53:38 -0400
Date: Tue, 25 Apr 2006 12:53:37 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [patch 2/4] kref debugging config option
Message-ID: <20060425045337.GB5698@miraclelinux.com>
References: <20060424083333.217677000@localhost.localdomain> <20060424083342.069630000@localhost.localdomain> <20060424143845.39412304.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424143845.39412304.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 02:38:45PM -0700, Andrew Morton wrote:
> Akinobu Mita <mita@miraclelinux.com> wrote:
> >
> > This patch converts all WARN_ON() in kref code to BUG_ON().
> 
> Why?  This change will irritate testers and will decrease their ability to
> capture (and hence report) diagnostic info.

I have no grudge against this BUG_ON().

But BUG_ON() is more prominent than WARN_ON().
Because I often could not realized whether WARN_ON() happned or not.

Should we make warn_counter which will be increment when WARN_ON()
happens, and export it as /proc/warn-counter? (also export die_counter
as /proc/die-counter) Then I'll make pretty gnome applet.

Or put the shell script which just do "dmesg | grep $warn_on_pattern".

