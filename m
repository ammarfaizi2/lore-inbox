Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUBIMlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUBIMlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:41:16 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:13837 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S265125AbUBIMlP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:41:15 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc1
Date: Mon, 9 Feb 2004 13:41:08 +0100
User-Agent: KMail/1.6
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <200402090234.20832.bzolnier@elka.pw.edu.pl> <4026F312.60703@tomt.net>
In-Reply-To: <4026F312.60703@tomt.net>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402091341.08526.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Monday 09 of February 2004 03:40, Andre Tomt napisa³:
> Ahh, indeed it does, _but_
>
> pdc202xx_old seems to have the same bug, making via82cxxx crash later on
> instead.
>
> Doing the same change to pdc202xx_old.h (removing __initdata) fixes this
> case too :-)

What about others?

./pdc202xx_old.h:static ide_pci_host_proc_t pdc202xx_procs[] = {
./hpt34x.h:static ide_pci_host_proc_t hpt34x_procs[] __initdata = {
./alim15x3.h:static ide_pci_host_proc_t ali_procs[] __initdata = {
./amd74xx.h:static ide_pci_host_proc_t amd74xx_procs[] __initdata = {
./cs5530.h:static ide_pci_host_proc_t cs5530_procs[] __initdata = {
./pdc202xx_new.h:static ide_pci_host_proc_t pdcnew_procs[] = {
./piix.h:static ide_pci_host_proc_t piix_procs[] __devinitdata = {
./sc1200.h:static ide_pci_host_proc_t sc1200_procs[] __initdata = {
./slc90e66.h:static ide_pci_host_proc_t slc90e66_procs[] __initdata = {
./serverworks.h:static ide_pci_host_proc_t svwks_procs[] __initdata = {
./cmd64x.h:static ide_pci_host_proc_t cmd64x_procs[] __initdata = {
./aec62xx.h:static ide_pci_host_proc_t aec62xx_procs[] __initdata = {
./siimage.h:static ide_pci_host_proc_t siimage_procs[] __initdata = {
./sis5513.h:static ide_pci_host_proc_t sis_procs[] __initdata = {
./via82cxxx.h:static ide_pci_host_proc_t via_procs[] __initdata = {
./hpt366.h:static ide_pci_host_proc_t hpt366_procs[] __initdata = {
./triflex.h:static ide_pci_host_proc_t triflex_proc __initdata = {
./cs5520.h:static ide_pci_host_proc_t cs5520_procs[] __initdata = {

all these __initdata (one __devinitdata) should also be removed?

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
