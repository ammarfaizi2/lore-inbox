Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWBTLyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWBTLyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWBTLyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:54:24 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:64429 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964855AbWBTLyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:54:23 -0500
Message-ID: <43F9AE63.2040208@sw.ru>
Date: Mon, 20 Feb 2006 14:56:19 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: Linus Torvalds <torvalds@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>  <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru>  <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <43E61448.7010704@sw.ru> <Pine.LNX.4.64.0602060847130.3854@g5.osdl.org> <43E7E998.2020007@vilain.net> <43E890CB.1060608@sw.ru> <43E91D85.6000100@vilain.net>
In-Reply-To: <43E91D85.6000100@vilain.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So why store anything other than the effective container in the task?
Effective container is used for temporary context change, e.g. when 
processing interrupts and need to handle skb. it is effective container 
for this code. just like get_fs()/set_fs() works.
Original container pointer is used for external process identification, 
e.g. whether to show task in /proc in context of another task.

Kirill

