Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWD1IaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWD1IaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 04:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWD1IaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 04:30:11 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:22795 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030358AbWD1IaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 04:30:09 -0400
Message-ID: <4451D28B.7000207@argo.co.il>
Date: Fri, 28 Apr 2006 11:30:03 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Denis Vlasenko <vda@ilport.com.ua>, Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44507BB9.7070603@argo.co.il> <200604271655.48757.vda@ilport.com.ua> <4450D4E9.4050606@argo.co.il> <mj+md-20060427.145744.9154.atrey@ucw.cz> <4450E3CB.1090206@argo.co.il> <mj+md-20060427.153429.15386.atrey@ucw.cz> <4451CF7A.5040902@argo.co.il>
In-Reply-To: <4451CF7A.5040902@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2006 08:30:08.0243 (UTC) FILETIME=[F52D3C30:01C66A9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
>    void put(Value& value)
>    {
>        // assumes value (or a value with an equal key) is not already in
>        Link& head = _buckets[Traits::hash(value) & (_size - 1)];
>        static_cast<Link&>(value).next = &head;
>        head.next= &value;
>    }
s/&head/head.next/ in the third line, of course.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

