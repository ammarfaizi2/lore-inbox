Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUALG3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 01:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266064AbUALG3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 01:29:11 -0500
Received: from 66-95-121-230.client.dsl.net ([66.95.121.230]:48590 "EHLO
	mail.lig.net") by vger.kernel.org with ESMTP id S266063AbUALG3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 01:29:09 -0500
Message-ID: <40023C74.1010109@lig.net>
Date: Mon, 12 Jan 2004 01:19:32 -0500
From: "Stephen D. Williams" <sdw@lig.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: High Quality Random sources, was: Re: SecuriKey
References: <5117BFF0551DD64884B32EE8CA57D3DB01548A3F@revere.nwpump.com> <4001ECBE.1020009@lig.net> <200401112238.32117.tabris@tabris.net> <200401112247.59418.tabris@tabris.net>            <40021E47.1070406@lig.net> <200401120557.i0C5v23e003260@turing-police.cc.vt.edu>
In-Reply-To: <200401120557.i0C5v23e003260@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has puzzled me for a while why it doesn't occur to people that a high 
quality OTP is a high quality source of shared private keys for a good 
symmetric algorithm.  That is a much better use than 1-to-1 XOR.  Sure, 
you're still only as secure as the symmetric algorithm but if you can 
manage distribution of a OTP, you don't have to otherwise worry about 
key management other than walking through the keys so that they are only 
used once.  128MB+ (or 200MB or 1GB)  represents a lot of AES keys.  
With that many, you could just skip around on a non-key aligned random 
point (using your high-quality random source of course ;-) ), transmit 
the point you are using as a key selector, and not worry about avoiding 
reuse management.

PKI is better for many reasons, but it's still interesting that an 
essentially low-tech technique like OTP could be used in a similar way.  
You still have an N^2 key exchange problem that PKI solves.

sdw

Valdis.Kletnieks@vt.edu wrote:

>On Sun, 11 Jan 2004 23:10:47 EST, "Stephen D. Williams" said:
>
>  
>
>>OTP absolutely requires that you share the OTP out of band, i.e. you 
>>twin a capture of random data.  Any transfer makes it as vulnerable as 
>>the transfer method.
>>    
>>
>
>The single most common OTP-related offense of Schneier's "snake oil crypto"
>has got to be the fact it's almost never only used exactly once and then discarded.
>
>So sure you can load 200 meg of OTP into the dongle before you leave the spy agency
>on a mission.  The fun starts when you get to the 201st megabyte of data. :)
>  
>

