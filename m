Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbUJ1KEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbUJ1KEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbUJ1KEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:04:07 -0400
Received: from sd291.sivit.org ([194.146.225.122]:31382 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262865AbUJ1KEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:04:01 -0400
Date: Thu, 28 Oct 2004 12:05:26 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 0/8] sonypi driver update
Message-ID: <20041028100525.GA3893@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches update the sonypi driver to the latest version.

The main changes in those patches are:
	- migrate to module_param();
	- power management: switch to a platform device, drop old PM code;
	- add full input support for the special keys;
	- whitespace, coding style related changes.

Full changelog below, the patches will be send as followups to this one.

Please apply.

Thanks,

Stelian.


PATCH 1/8: sonypi: module related fixes
        * use module_param() instead of MODULE_PARM() and __setup()
        * use MODULE_VERSION()

PATCH 2/8: sonypi: replace homebrew queue with kfifo

PATCH 3/8: sonypi: power management related fixes
        * switch from a sysdev to a platform device
        * drop old style PM code
        * use pci_get_device()/pci_dev_put() instead of pci_find_device()

PATCH 4/8: sonypi: rework input support
        * feed most of special keys through the input subsystem
        * initialize two separate input devices: a mouse like one for
          the jogdial and a keyboard like one for the special keys
        * add support for SONYPI_EVENT_FNKEY_RELEASED

PATCH 5/8: sonypi: make CONFIG_SONYPI depend on CONFIG_INPUT since the latter is no more 
optional.

PATCH 6/8: sonypi: don't suppose the bluetooth subsystem is initialy off,
          leave the choice to the user.

PATCH 7/8: sonypi: whitespace and coding style fixes

PATCH 8/8: sonypi: bump up the version number

-- 
Stelian Pop <stelian@popies.net>    
