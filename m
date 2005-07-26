Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVGZGID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVGZGID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 02:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVGZGID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 02:08:03 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:57837 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261736AbVGZGIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 02:08:01 -0400
Date: Tue, 26 Jul 2005 08:07:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Philippe Troin <phil@fifi.org>, Steven Rostedt <rostedt@goodmis.org>,
       Bernd Petrovitsch <bernd@firmix.at>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Grant Coady <lkml@dodo.com.au>, Puneet Vyas <vyas.puneet@gmail.com>
Subject: Re: xor as a lazy comparison
In-Reply-To: <1122319117.1472.15.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0507260804230.26583@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr> 
 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>  <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
  <42E4131D.6090605@gmail.com> <1122281833.10780.32.camel@tara.firmix.at> 
 <1122314150.6019.58.camel@localhost.localdomain>  <1122318659.1472.14.camel@mindpipe>
  <87ackaitlj.fsf@ceramic.fifi.org> <1122319117.1472.15.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Where do we draw the line with this?  Is x *= 2 preferable to x <<= 2 as
>> > well?
>> 
>> Depends if you want to multiply by 2 or 4 :-)
>
>I guess I just answered my own question ;-)

To answer for x *= 2 vs x <<= 1:

Use * when you would logically want to do a multiplication,
<< if you're working on a bitfield. It's just for keeping the code clean 
enough so that others may understand it.

In the longshot, it does not matter, as gcc will optimize out multiplication 
with powers of two to bitops.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
