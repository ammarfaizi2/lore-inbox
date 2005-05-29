Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVE2ABe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVE2ABe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 20:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVE2ABe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 20:01:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35722 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261243AbVE2AB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 20:01:27 -0400
Date: Sat, 28 May 2005 20:01:21 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-git3 ia64 acpi build breakage.
Message-ID: <20050529000121.GA15681@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is puzzling.
In file included from drivers/firmware/pcdp.c:18:
drivers/firmware/pcdp.h:48: error: field 'addr' has incomplete type
drivers/firmware/pcdp.c: In function 'setup_serial_console':
drivers/firmware/pcdp.c:27: error: 'ACPI_ADR_SPACE_SYSTEM_MEMORY' undeclared (first use in this function)
drivers/firmware/pcdp.c:27: error: (Each undeclared identifier is reported only once
drivers/firmware/pcdp.c:27: error: for each function it appears in.)

First, I thought this was a simple missing
#include <acpi/actypes.h>

in drivers/firmware/pcdp.c

But it still spat out the same warning.

		Dave

