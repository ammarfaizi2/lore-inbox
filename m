Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbWD1Pri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbWD1Pri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWD1Pri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:47:38 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28879 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030443AbWD1Prh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:47:37 -0400
Date: Fri, 28 Apr 2006 17:47:04 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: Martin Mares <mj@ucw.cz>, Denis Vlasenko <vda@ilport.com.ua>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
In-Reply-To: <4451CF7A.5040902@argo.co.il>
Message-ID: <Pine.LNX.4.61.0604281744310.9011@yvahk01.tjqt.qr>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com>
 <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44507BB9.7070603@argo.co.il>
 <200604271655.48757.vda@ilport.com.ua> <4450D4E9.4050606@argo.co.il>
 <mj+md-20060427.145744.9154.atrey@ucw.cz> <4450E3CB.1090206@argo.co.il>
 <mj+md-20060427.153429.15386.atrey@ucw.cz> <4451CF7A.5040902@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> #include <cassert>
>
> template <typename Key, class Value, class Traits>
> class Hashtable
> {
> public:
> class Link {

Does not match CodingStyle. SCNR.

>   assert((_size & (_size -  1)) == 0);

Names with underscores are usually reserved.

> // example program
>
> static unsigned hash(const char* key)
> {
> // assume this is jenkin's hash.
> unsigned h = 0;
> while (*key) {
> h = (h << 3) | (h >> 29);
> h ^= (unsigned char)*key++;

No const_cast<> and static_cast<> here?



Jan Engelhardt
-- 
