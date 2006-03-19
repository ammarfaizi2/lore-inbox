Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWCSRig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWCSRig (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 12:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWCSRig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 12:38:36 -0500
Received: from main.gmane.org ([80.91.229.2]:12759 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751521AbWCSRig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 12:38:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sun, 19 Mar 2006 19:38:20 +0200
Message-ID: <dvk4tv$9j9$1@sea.gmane.org>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org> <yw1x64mb7rwm.fsf@agrajag.inprovide.com> <dvh7aj$95v$1@sea.gmane.org> <yw1xoe0368yj.fsf@agrajag.inprovide.com> <dvjcb4$as2$1@sea.gmane.org> <yw1xd5gi381h.fsf@agrajag.inprovide.com> <dvjsa6$i92$1@sea.gmane.org> <yw1xslpez928.fsf@agrajag.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84.247.49.226
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> Hmm, we seem to be using different patches.  Here's what I'm using:
> 
Oh, yeah. I used the original one posted here (actually I get from some -mm
patch collection IIRC, I don't remember from which one).

Anyway, my suggestion remains, that the 
+       if (dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK)
+               return;
+       if (dev->device != PCI_DEVICE_ID_VIA_8237)
+               return;

might be not needed at all as it is not ASUS specific. I don't understand
the second if, as (from my limited knowledge) it seems that 

DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_8237,
asus_hides_ac97_lpc );

already means the function will be called only for devices with PCI id
PCI_DEVICE_ID_VIA_8237 .

Andras
-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org


