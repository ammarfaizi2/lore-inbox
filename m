Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbVLGBFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbVLGBFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 20:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbVLGBFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 20:05:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48604 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932674AbVLGBFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 20:05:46 -0500
Date: Tue, 6 Dec 2005 20:05:26 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk
Subject: Missing break in timedia serial setup.
Message-ID: <20051207010526.GA7258@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted during code review by a Fedora user.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=174967

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/serial/8250_pci.c~	2005-12-06 20:01:17.000000000 -0500
+++ linux-2.6.14/drivers/serial/8250_pci.c	2005-12-06 20:01:51.000000000 -0500
@@ -517,6 +517,7 @@ pci_timedia_setup(struct serial_private 
 	case 3:
 		offset = board->uart_offset;
 		bar = 1;
+		break;
 	case 4: /* BAR 2 */
 	case 5: /* BAR 3 */
 	case 6: /* BAR 4 */
