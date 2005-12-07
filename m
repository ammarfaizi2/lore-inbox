Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbVLGRoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbVLGRoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVLGRoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:44:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25516 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751461AbVLGRoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:44:22 -0500
Date: Wed, 7 Dec 2005 12:44:09 -0500
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Missing break in timedia serial setup.
Message-ID: <20051207174409.GE3574@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20051207010526.GA7258@redhat.com> <20051207093431.GB32365@flint.arm.linux.org.uk> <20051207165811.GA3574@redhat.com> <1133975119.2869.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133975119.2869.49.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 06:05:19PM +0100, Arjan van de Ven wrote:

 > might as well add a /* fall through */ comment
 > so that this doesn't come up again in the future..

Remove redundant assignment, and mark fallthrough.
 
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/serial/8250_pci.c~	2005-12-07 12:42:58.000000000 -0500
+++ linux-2.6.14/drivers/serial/8250_pci.c	2005-12-07 12:43:08.000000000 -0500
@@ -516,7 +516,7 @@ pci_timedia_setup(struct serial_private 
 		break;
 	case 3:
 		offset = board->uart_offset;
-		bar = 1;
+		/* FALLTHROUGH */
 	case 4: /* BAR 2 */
 	case 5: /* BAR 3 */
 	case 6: /* BAR 4 */
