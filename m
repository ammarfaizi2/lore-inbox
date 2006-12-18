Return-Path: <linux-kernel-owner+w=401wt.eu-S1754513AbWLRUGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbWLRUGH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754511AbWLRUGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:06:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:21321 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbWLRUGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:06:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n/IAvVGw0H0Uj2eYGkO7DGMkJEPIzKrJcIW+6zn1TrZym7PqudD5txlqcwcP/fhBy6d/jykouJ5KIQcbIDsvZUWcsT8t9I/YBNFPM/1SusezKBmIBy/Ys8+P79JslYrYSpXwlmsUUne7nzBbxhoLxMP9t2+F5fd+NoCy5OjGSsM=
Message-ID: <58cb370e0612181206m24a7a58eqa318ea5a3cb88d74@mail.gmail.com>
Date: Mon, 18 Dec 2006 21:06:03 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: 2.6.20-rc1-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061214225913.3338f677.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/06, Andrew Morton <akpm@osdl.org> wrote:

> +toshiba-tc86c001-ide-driver-take-2.patch

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

IMO this can be merged for 2.6.20 as it is new driver
(which is clean, tested and acked by Alan already)

> All 693 patches:

hpt3xx-rework-rate-filtering.patch
  HPT3xx: rework rate filtering

ACK

hpt3xx-rework-rate-filtering-tidy.patch
  hpt3xx-rework-rate-filtering-tidy

ACK

hpt3xx-print-the-real-chip-name-at-startup.patch
  HPT3xx: print the real chip name at startup

ACK

hpt3xx-switch-to-using-pci_get_slot.patch
  HPT3xx: switch to using pci_get_slot()

ACK

hpt3xx-cache-channels-mcr-address.patch
  [PATCH] HPT3xx: cache channel's MCR address

ACK

hpt3x7-merge-speedproc-handlers.patch
  HPT3x7: merge speedproc handlers

ACK

hpt370-clean-up-dma-timeout-handling.patch
  HPT370: clean up DMA timeout handling

ACK

hpt3xx-init-code-rewrite.patch
  HPT3xx: init code rewrite

ACK

piix-fix-82371mx-enablebits.patch
  PIIX: fix 82371MX enablebits

ACK, thought I haven't compared wrt datasheet yet

piix-remove-check-for-broken-mw-dma-mode-0.patch
  PIIX: remove check for broken MW DMA mode 0

ACK, 100% correct and non-intrusive cleanup

piix-slc90e66-pio-mode-fallback-fix.patch
  PIIX/SLC90E66: PIO mode fallback fix

ACK, this is an important bugfix

pdc202xx_new-remove-useless-code.patch
  pdc202xx_new: remove useless code

ACK, nice cleanup

pdc202xx_-remove-check_in_drive_lists-abomination.patch
  pdc202xx_*: remove check_in_drive_lists() abomination

ACK, ditto

I think that all above patches from Sergei should be merged now as they
are either bugfixes or not-intrusive cleanups and got more than enough
exposure in -mm (since 2.6.17-mm).

jmicron-warning-fix.patch

Wouldn't it be neater to add BUG() instead?  Seems to fix warning
for me and documents nicely that this case cannot happen.

Thanks,
Bart
