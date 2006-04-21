Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWDUOMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWDUOMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWDUOMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:12:09 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:62422 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932296AbWDUOMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:12:07 -0400
Date: Fri, 21 Apr 2006 16:12:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lukasz Stelmach <stlman@poczta.fm>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: unix socket connection tracking
In-Reply-To: <4448DF94.5030500@poczta.fm>
Message-ID: <Pine.LNX.4.61.0604211610500.31515@yvahk01.tjqt.qr>
References: <44480BD9.5080100@poczta.fm> <Pine.LNX.4.61.0604211452490.23180@yvahk01.tjqt.qr>
 <4448DF94.5030500@poczta.fm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I feel dumb as never so please enlight me. Is ther a way to find out which
>>> process is on the other end of a unix socket pointed by a specified fd in a process.
>> 
>> getpeer*()
>
>getpeername(2) (that is the only man page I've got)
>
Exactly. And if you do the same on another socket from another process, you 
can match up what sockets are connected.
You always need to examine more than one process. (Unless the process talks 
to itself.)

>That's not exactly what I want. Or even exactly not what I want. I want to learn
>about sockets from a third person perspective. I've got a process which I can
>strace(1), but nothing more, and I want to know who is it talking to.
>

Jan Engelhardt
-- 
