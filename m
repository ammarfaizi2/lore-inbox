Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbTLRLCL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 06:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbTLRLCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 06:02:10 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:47499 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265085AbTLRLCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 06:02:07 -0500
Date: Thu, 18 Dec 2003 12:02:05 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test11 BK: sg and scanner modules not auto-loaded?
Message-ID: <20031218110204.GA28467@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have
alias char-major-21 sg

in /etc/modprobe.conf, but still my sg module is not loaded
automatically on first access to /dev/sg0. I must load the module
manually ("modprobe sg" will do).

Similar considerations apply to scanner:
alias char-major-180-48 scanner

is in /etc/modprobe.conf, but opening such a device doesn't read the
module. I'm not sure if it's hotplug's task to pull this module in, this
is SuSE Linux 8.2.

.config snippet:
#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
