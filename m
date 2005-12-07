Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVLGR2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVLGR2e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVLGR2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:28:33 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:726 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751228AbVLGR2d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:28:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C1pnmaXqrlXqb0kjLonaN2JknKot8v0ArZvOSmYPvpygyCm42Mgn5rdDrfr5kmLNyJyHEAgzDgidpLvtIq4IDvBp2dH/2zKlb1s00q3SD9NWuBZxxj7FSvj56l7X3B+Df16zkDm4weP+OeJ9RxYDrK8GTC8pW7Ka85U2ovDMAS4=
Message-ID: <808c8e9d0512070928y6f50be0arcba9404de2f68f78@mail.gmail.com>
Date: Wed, 7 Dec 2005 11:28:30 -0600
From: Ben Gardner <gardner.ben@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] i386: CS5535 chip support (Geode companion chip)
Cc: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the AMD CS5535, which is the Geode
companion chip.  It targets the DIVIL (Diverse Integrated Logic)
components.

Patch 1 does the following:
 - verifies the existence of the CS5535 by checking the DIVIL signature
 - configures UART1 as a NS16550A
 - (optionally) enables UART2 and configures it as a NS16550A
 - (optionally) enables the SMBus/I2C interface

Patch 2 provides a simple GPIO char driver, modeled after the
scx200_gpio driver.

Patch 3 provides a SMBus/I2C driver, modeled after the scx200_acb driver.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
