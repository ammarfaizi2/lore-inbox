Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUBIOgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 09:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUBIOgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 09:36:06 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63201 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265238AbUBIOgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 09:36:02 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: Linux 2.6.3-rc1
Date: Mon, 9 Feb 2004 15:41:32 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <4026F312.60703@tomt.net> <200402091341.08526.arekm@pld-linux.org>
In-Reply-To: <200402091341.08526.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200402091541.32130.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 of February 2004 13:41, Arkadiusz Miskiewicz wrote:
> Dnia Monday 09 of February 2004 03:40, Andre Tomt napisa³:
> > Ahh, indeed it does, _but_
> >
> > pdc202xx_old seems to have the same bug, making via82cxxx crash later on
> > instead.
> >
> > Doing the same change to pdc202xx_old.h (removing __initdata) fixes this
> > case too :-)
>
> What about others?
>
> ./pdc202xx_old.h:static ide_pci_host_proc_t pdc202xx_procs[] = {
> ./hpt34x.h:static ide_pci_host_proc_t hpt34x_procs[] __initdata = {
> ./alim15x3.h:static ide_pci_host_proc_t ali_procs[] __initdata = {
> ./amd74xx.h:static ide_pci_host_proc_t amd74xx_procs[] __initdata = {
> ./cs5530.h:static ide_pci_host_proc_t cs5530_procs[] __initdata = {
> ./pdc202xx_new.h:static ide_pci_host_proc_t pdcnew_procs[] = {
> ./piix.h:static ide_pci_host_proc_t piix_procs[] __devinitdata = {
> ./sc1200.h:static ide_pci_host_proc_t sc1200_procs[] __initdata = {
> ./slc90e66.h:static ide_pci_host_proc_t slc90e66_procs[] __initdata = {
> ./serverworks.h:static ide_pci_host_proc_t svwks_procs[] __initdata = {
> ./cmd64x.h:static ide_pci_host_proc_t cmd64x_procs[] __initdata = {
> ./aec62xx.h:static ide_pci_host_proc_t aec62xx_procs[] __initdata = {
> ./siimage.h:static ide_pci_host_proc_t siimage_procs[] __initdata = {
> ./sis5513.h:static ide_pci_host_proc_t sis_procs[] __initdata = {
> ./via82cxxx.h:static ide_pci_host_proc_t via_procs[] __initdata = {
> ./hpt366.h:static ide_pci_host_proc_t hpt366_procs[] __initdata = {
> ./triflex.h:static ide_pci_host_proc_t triflex_proc __initdata = {
> ./cs5520.h:static ide_pci_host_proc_t cs5520_procs[] __initdata = {
>
> all these __initdata (one __devinitdata) should also be removed?

Yes.  Patch should be already in Linus' mailbox.

