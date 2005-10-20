Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVJTS6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVJTS6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 14:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVJTS6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 14:58:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25049 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932096AbVJTS6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 14:58:32 -0400
Date: Thu, 20 Oct 2005 14:58:19 -0400
From: Dave Jones <davej@redhat.com>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.4: 'find' complained about sysfs
Message-ID: <20051020185818.GD3590@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Harald Dunkel <harald.dunkel@t-online.de>,
	linux-kernel@vger.kernel.org
References: <4357E4E9.4@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4357E4E9.4@t-online.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 08:41:45PM +0200, Harald Dunkel wrote:
 > Hi folks,
 > 
 > When I ran 'find /sys -name modalias' I got an error
 > message on stderr saying
 > 
 > find: WARNING: Hard link count is wrong for /sys/devices: this may be a bug in your filesystem driver.  Automatically turning on find's -noleaf option.  Earlier results may have failed to include directories that should have been searched.

This has been around for a while. It's very likely this..

(14:56:22:davej@nwo:~)$ ll /sys/devices/system/
total 0
drwxr-xr-x  3 root root 0 Oct 20 10:09 acpi/
drwxr-xr-x  6 root root 0 Oct 20 10:08 cpu/
drwxr-xr-x  3 root root 0 Oct 20 10:08 i8237/
drwxr-xr-x  3 root root 0 Oct 20 10:08 i8259/
drwxr-xr-x  5 root root 0 Oct 20 10:08 ioapic/
drwxr-xr-x  3 root root 0 Oct 20 10:08 irqrouter/
drwxr-xr-x  3 root root 0 Oct 20 10:08 lapic/
drwxr-xr-x  3 root root 0 Oct 20 10:09 lapic_nmi/
drwxr-xr-x  6 root root 0 Oct 20 10:08 machinecheck/
drwxr-xr-x  3 root root 0 Oct 20 10:08 node/
drwxr-xr-x  3 root root 0 Oct 20 10:08 timer/
drwxr-xr-x  3 root root 0 Oct 20 10:08 timer/             <---- Oops.
(14:56:24:davej@nwo:~)$


		Dave
