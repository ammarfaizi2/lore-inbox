Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752935AbWKFMiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbWKFMiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbWKFMiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:38:55 -0500
Received: from qb-out-0506.google.com ([72.14.204.231]:35291 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752935AbWKFMiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:38:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Hpo72oUwi0qsZHx37bnUGRRWGodxQQwe4YUdqRzm1bhGeUURzgotbQa+8t8lhpzeQSVWPb6D5TC0fSPyKpPp1aUzYRez15YYTaVup6hi6l4I1RGZZWxlDXU05ghjXcXPoqi5LdE69f4uJaEGuEmWt65ZMETyjMuxTUrcKuD7rwE=
Message-ID: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
Date: Mon, 6 Nov 2006 12:38:21 +0100
From: "Wilco Beekhuizen" <wilcobeekhuizen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: VIA IRQ quirk missing PCI ids since 2.6.16.17
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, since 2.6.17.17 in drivers/pci/quirks.c (quirk_via_irq) all VIA
chipsets are listed seperately instead of the "include everything"
PCI_ANY_ID.

This is however problematic with my chipset.
The ethernet controller, a VT6102 (Rhine-II) and the audio controller,
VT8233/A/8235/8237 need a fix to work.
Including PCI_ANY_ID again fixes these problems but is of course a
pretty evil fix. The problem is I can't find out which PCI ids to
include. I'm new to this list so suggestions are welcome.

Wilco
