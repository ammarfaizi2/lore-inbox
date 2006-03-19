Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWCSSD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWCSSD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWCSSD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:03:57 -0500
Received: from main.gmane.org ([80.91.229.2]:44497 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751567AbWCSSD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:03:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sun, 19 Mar 2006 18:03:03 +0000
Message-ID: <yw1xbqw2z50o.fsf@agrajag.inprovide.com>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org> <yw1x64mb7rwm.fsf@agrajag.inprovide.com> <dvh7aj$95v$1@sea.gmane.org> <yw1xoe0368yj.fsf@agrajag.inprovide.com> <dvjcb4$as2$1@sea.gmane.org> <yw1xd5gi381h.fsf@agrajag.inprovide.com> <dvjsa6$i92$1@sea.gmane.org> <yw1xslpez928.fsf@agrajag.inprovide.com> <dvk4tv$9j9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:f+Wgkd/srTqZaEhzkx3sE8YmSFQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andras Mantia <amantia@kde.org> writes:

> Måns Rullgård wrote:
>
>> Hmm, we seem to be using different patches.  Here's what I'm using:
>> 
> Oh, yeah. I used the original one posted here (actually I get from
> some -mm patch collection IIRC, I don't remember from which one).

OK, I just used the simpler (and newer) of the two versions that were
posted, and modified as suggested by someone.  Does my version work on
your machine?

> Anyway, my suggestion remains, that the 
> +       if (dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK)
> +               return;
> +       if (dev->device != PCI_DEVICE_ID_VIA_8237)
> +               return;
>
> might be not needed at all as it is not ASUS specific.

Doesn't it depend on the BIOS?  My BIOS lets me choose between
"automatic" and "disabled" for the onboard sound.

> I don't understand the second if, as (from my limited knowledge) it
> seems that
>
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_8237,
> asus_hides_ac97_lpc );
>
> already means the function will be called only for devices with PCI id
> PCI_DEVICE_ID_VIA_8237 .

That struck me too.  

-- 
Måns Rullgård
mru@inprovide.com

