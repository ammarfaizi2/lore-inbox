Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbUK2RpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUK2RpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 12:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUK2RpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 12:45:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2717 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261432AbUK2Ro3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 12:44:29 -0500
Date: Mon, 29 Nov 2004 18:44:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: ppcfix.diff
In-Reply-To: <20041129172252.GN26051@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.53.0411291843360.9120@yvahk01.tjqt.qr>
References: <20041129154041.GB4616@hugang.soulinfo.com>
 <20041129172252.GN26051@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  	if (!cpus_empty(keepmask)) {
>> -		cpumask_t irqdest = { .bits[0] = openpic_read(&ISR[irq]->Destination) };
>> +		cpumask_t irqdest;
>> +		irqdest.bits[0] = openpic_read(&ISR[irq]->Destination);
>
>Not an equivalent replacement.  The former means "set irqdest.bits[0] to
><expression> and set the rest of fields/array elements in them to zero/null".

Really? I thought zero'ing only happens for static storage.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
