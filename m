Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbRFUQ3g>; Thu, 21 Jun 2001 12:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265020AbRFUQ30>; Thu, 21 Jun 2001 12:29:26 -0400
Received: from smtp02.fields.gol.com ([203.216.5.132]:34062 "EHLO
	smtp02.fields.gol.com") by vger.kernel.org with ESMTP
	id <S265018AbRFUQ3X>; Thu, 21 Jun 2001 12:29:23 -0400
Date: Fri, 22 Jun 2001 01:28:59 +0900
From: Masaru Kawashima <masaruk@gol.com>
To: Dionysius Wilson Almeida <dwilson@technolunatic.com>
Cc: linux-kernel@vger.kernel.org, "Andrey V. Savochkin" <saw@saw.sw.com.sg>
Subject: Re: eepro100: wait_for_cmd_done timeout
Message-Id: <20010622012859.5ecccbf5.masaruk@gol.com>
In-Reply-To: <20010621231939.757bddd6.masaru@scji.toshiba-eng.co.jp>
In-Reply-To: <20010620163134.A22173@technolunatic.com>
	<20010621231939.757bddd6.masaru@scji.toshiba-eng.co.jp>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.9; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__22_Jun_2001_01:28:59_+0900_09664948"
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__22_Jun_2001_01:28:59_+0900_09664948
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, again!
I'ts me, Masaru Kawashima, from home.

I'm sorry I made a stupid mistake last time!
This time, I promise you that I attach the proper patch for
linux/drivers/net/eepro100.c.  (running version)

On Thu, 21 Jun 2001 23:19:39 +0900
Masaru Kawashima <Masaru Kawashima <masaru@scji.toshiba-eng.co.jp>> wrote:

> Hi!
> 
> On Wed, 20 Jun 2001 16:31:34 -0700
> Dionysius Wilson Almeida <Dionysius Wilson Almeida <dwilson@technolunatic.com>> wrote:
> > Jun 20 16:14:07 debianlap kernel: eepro100: wait_for_cmd_done timeout!
> > Jun 20 16:14:38 debianlap last message repeated 5 times
> 
> I saw the same message.
> 
> The comment before wait_for_cmd_done() function in
> linux/drivers/net/eepro100.c says:
> /* How to wait for the command unit to accept a command.
>    Typically this takes 0 ticks. */
> 
> And the initial value for the bogus counter, named "wait", is 1000.
> Is it enough for your machine?
> 
> I applied attached patch, eepro100.patch.  After that, I've never seen
> the message from wait_for_cmd_done().  And, my NIC works fine.
> 
> You may want to adjust the initial value for the bogus counter.
> I don't know the appropriate value for this bogus counter.
> 
> I hope this helps you.
> 
> -- 
> Masaru Kawashima

--
Masaru Kawashima
--Multipart_Fri__22_Jun_2001_01:28:59_+0900_09664948
Content-Type: text/plain;
 name="eepro100.correct.patch"
Content-Disposition: attachment;
 filename="eepro100.correct.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNC41L2RyaXZlcnMvbmV0L2VlcHJvMTAwLmMub3JnCUZyaSBNYXkgMjUgMTg6
NTk6MDMgMjAwMQorKysgbGludXgtMi40LjUvZHJpdmVycy9uZXQvZWVwcm8xMDAuYwlGcmkgSnVu
IDIyIDAwOjU1OjAzIDIwMDEKQEAgLTMwOSw4ICszMDksOSBAQAogc3RhdGljIGlubGluZSB2b2lk
IHdhaXRfZm9yX2NtZF9kb25lKGxvbmcgY21kX2lvYWRkcikKIHsKIAlpbnQgd2FpdCA9IDEwMDA7
Ci0JZG8gICA7Ci0Jd2hpbGUoaW5iKGNtZF9pb2FkZHIpICYmIC0td2FpdCA+PSAwKTsKKwl3aGls
ZShpbmIoY21kX2lvYWRkcikgJiYgLS13YWl0ID49IDApeworCQl1ZGVsYXkoMSk7CisJfQogI2lm
bmRlZiBmaW5hbF92ZXJzaW9uCiAJaWYgKHdhaXQgPCAwKQogCQlwcmludGsoS0VSTl9BTEVSVCAi
ZWVwcm8xMDA6IHdhaXRfZm9yX2NtZF9kb25lIHRpbWVvdXQhXG4iKTsK

--Multipart_Fri__22_Jun_2001_01:28:59_+0900_09664948--
