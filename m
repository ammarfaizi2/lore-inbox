Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVLUKzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVLUKzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 05:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVLUKzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 05:55:54 -0500
Received: from mail.e2brain.de ([62.159.155.200]:16183 "EHLO
	kom-exchfe.kontron-modular.com") by vger.kernel.org with ESMTP
	id S932357AbVLUKzx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 05:55:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: AW: Submitting patches for Kontron-boards with Freescale processors
Date: Wed, 21 Dec 2005 11:56:45 +0100
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E232F@kom-mailsrv1.kontron-modular.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Submitting patches for Kontron-boards with Freescale processors
Thread-Index: AcYErfgrVmlWS9i7Qe2WlMvPmFDs+gBbfAFA
From: "Claus Gindhart" <Claus.Gindhart@kontron.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Dec 2005 10:55:43.0640 (UTC) FILETIME=[17010980:01C6061D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar,

Due to your E-Mail i have checked into the linuxppc mailing lists. I am aware now of the restructuring process in the Kernel regarding the flattened device tree for passing parameters from the Bootloader to the Kernel.

Actually all Kontron-PowerPC-Boards, (VME-, CompactPCI- and E²Brain- boards) are equipped with the Kontron NetBootLoader. This Ecos-based bootloader currently passes all parameters to the Kernel via an E²PROM-Device. We have also some custom projects using U-Boot, but our standard products all have the Kontron Bootloader.

The question is now: Will it be a mandatory requirement, that the Bootloader provides the flattened device list, or will it be allowed in future to provide a platform-specific function, which generates the flattened device tree (as we previously did within the embed_config() function, where we built the struct bd_t) ?

- Claus

-----Ursprüngliche Nachricht-----
Von: Kumar Gala [mailto:galak@kernel.crashing.org]
Gesendet: Montag, 19. Dezember 2005 16:07
An: Claus Gindhart
Cc: Linux Kernel List
Betreff: Re: Submitting patches for Kontron-boards with Freescale
processors



On Dec 19, 2005, at 2:07 AM, Claus Gindhart wrote:

> Kumar,
>
> in our department we have Linux 2.6 kernel ports for Kontron  
> embedded computer boards with freescale processors 8245, 405, 8540,  
> 8541, 8347, 8270, ...
>
> We would like to start now to submit all these board supports to  
> the vanilla kernel.
>
> For the start we would select one of our common boards, e.g. the  
> one with 8540/8541 processor.
>
> My question is now:
> Should we try to provide a patch with all HW-features of the board  
> supported, or would it be better to start with a minimalistic  
> patch, and then add support for additional devices onboard (e.g.  
> IDE, RTC, SuperIO, ...) time by time ?
>
> Or would it be better to provide the full feature set of this board  
> at one time ?

First, I would recommend posting such queries to the linuxppc lists  
(linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org).

Second, I'm no longer at Freescale so please email me at this address.

Ok, now to your question.  In general if a given board port touch  
files in arch/ppc/platforms/* than all of that code should be in one  
patch.  If you are touching anything in drivers/* you need to  
separate out those patches and send them to the respective driver  
maintainers.  If you want to provide a more detailed list of changes  
for 8540/8541 I can provide better directions on how to submit patches.

What boot loader are you using for your boards?  I ask because for  
the 85xx and 83xx subarchitectures I'm trying to limit new board  
ports in arch/ppc as we try to transition to arch/powerpc.  However,  
this requires that the firmware provide a flatten device tree to the  
kernel.

Hopefully that gets you a sense and feel free to ask any other  
questions.

- kumar


