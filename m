Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbTIJLXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbTIJLXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:23:20 -0400
Received: from h126n1fls32o965.telia.com ([217.208.162.126]:20701 "EHLO
	twinsrv.twinox.se") by vger.kernel.org with ESMTP id S262666AbTIJLXT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:23:19 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
Subject: SV: Efficient IPC mechanism on Linux
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 10 Sep 2003 13:23:18 +0200
Message-ID: <F71B37536F3B3D4FA521FEC7FCA17933164D@twinsrv.twinox.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Efficient IPC mechanism on Linux
Thread-Index: AcN3ig+3wH24X43tRgW/WNRpBoIzNQAAUuxg
From: "Lars Hammarstrand" <lars@twinox.se>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>On Wed, Sep 10, 2003 at 12:54:32PM +0200, Luca Veraldi wrote:
>> > Memory is sort of starting to be like disk IO in this regard.
>> 
>> Good. So the less you copy memory all around, the better you permorm.
>>
>Actually it's "the less discontiguos memory you touch the better you
perform". Just like a 128Kb read is about the same cost as a 4Kb disk
read, the same >>is starting to become true for memory copies. So in the
extreme the memory copy is one operation only.

Well yes, that might be true for a one user desktop system. But
shouldn't we meet the demands from the "data center" users as well? Now,
I do hereby claim that: 1000 process/threads doing 128Kb reads is
_absolute_ not the same as 1000 process/threads doing 4Kb disk reads in
terms of i/o, memory and bus bandwidth. 

Anyone willing to bet on this one?

Bottom line - don't waste unnecessary bandwidth, others might need it.
--

Lars.
