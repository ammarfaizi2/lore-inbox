Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbUJaGcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbUJaGcc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 01:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbUJaGcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 01:32:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35233 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261509AbUJaGcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 01:32:20 -0500
Date: Sun, 31 Oct 2004 07:32:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
cc: reiser@namesys.com
Subject: Re: readdir loses renamed files
In-Reply-To: <4183E775.3090701@namesys.com>
Message-ID: <Pine.LNX.4.53.0410310726060.3581@yvahk01.tjqt.qr>
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org>
 <20041028093426.GB15050@merlin.emma.line.org> <20041028114413.GL1343@schnapps.adilger.int>
 <4182B2FF.9040902@namesys.com> <Pine.LNX.4.53.0410292326300.8389@yvahk01.tjqt.qr>
 <4183E775.3090701@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>It should be possible to perform an atomic readdir if that is what you
>>>want to do and if you have space in your process to stuff the result.
>>
>>How much would it cost to always append the new name into the directory rather
>>than modifying it in place?
>
>Forgive me, what does the sentence above mean?  Paste it out of order?

As I have read from earlier replies, ext2/3 replaces a filename with the new
one, given that it is the same length or shorter, and especially that might
skip a while when readdir()ing.
So I was concerned about the speed impact which would arise, if the filename
was never modified in-place but always appended as a new object to the
end-of-directory.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
