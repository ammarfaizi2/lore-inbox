Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278112AbRJLURG>; Fri, 12 Oct 2001 16:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278114AbRJLUQ4>; Fri, 12 Oct 2001 16:16:56 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:9533 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S278112AbRJLUQq>; Fri, 12 Oct 2001 16:16:46 -0400
Message-ID: <71714C04806CD51193520090272892178BD709@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: jgarzik@mandrakesoft.com, vonbrand@inf.utfsm.cl
Cc: linux-kernel@vger.kernel.org
Subject: RE: crc32 cleanups
Date: Fri, 12 Oct 2001 15:17:12 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That leaves (a) unconditionally building 
> it into the kernel, or (b) Makefile and Config.in rules.

(a) is simple, but needs a 1KB malloc (or alternately, a 1KB static const
array - I've taken the approach that the malloc is better)
(b) isn't that much harder, but requires drivers to be sure to call
init_crc32 and cleanup_crc32.  If somehow they manage not to do that, Oops.
I don't want to add a runtime check for the existance of the array in
crc32().

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!
