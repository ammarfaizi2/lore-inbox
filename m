Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164371AbWLHCQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164371AbWLHCQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 21:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164374AbWLHCQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 21:16:36 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:48156 "HELO
	mailer2-1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1164371AbWLHCQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 21:16:36 -0500
Message-ID: <4578CAFC.2010206@scientia.net>
Date: Fri, 08 Dec 2006 03:16:28 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: vherva@vianova.fi, Chris Wedgwood <cw@f00f.org>,
       Erik Andersen <andersen@codepoet.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <4570CF26.8070800@scientia.net> <20061202051720.GA12580@tuatara.stupidest.org> <20061202111644.GF9995@vianova.fi>
In-Reply-To: <20061202111644.GF9995@vianova.fi>
Content-Type: multipart/mixed;
 boundary="------------070802000001060609030808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070802000001060609030808
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ville Herva wrote:
> I saw something very similar with Via KT133 years ago. Then the culprit was
> botched PCI implementation that sometimes corrupted PCI transfers when there
> was heavy PCI I/O going on. Usually than meant running two disk transfers at
> the same time. Doing heavy network I/O at the time made it more likely
> happen.
Hm I do only on concurrent test,... and network is not used very much
during the tests.


> I used this crude hack:
> http://v.iki.fi/~vherva/tmp/wrchk.c
>   
I'll have a look at it :)


> If the problem in your case is that the PCI transfer gets corrupted when it
> happens to a certain memory area, I guess you could try to binary search for
> the bad spot with the kernel BadRam patches
> http://www.linuxjournal.com/article/4489 (I seem to recall it was possible
> to turn off memory areas with vanilla kernel boot params without a patch,
> but I can't find a reference.)
>   

I know badram,.. but the thing is,.. that it's highly unlikely that my
RAMs are damaged. Many hours of memtest86+ runs did not show any error
(not even ECC errors),...

And why should memhol mapping disabled solve the issue if memory was
damaged? That could only be if the badblocks would be in the address
space used by the memhole....

Chris.

--------------070802000001060609030808
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------070802000001060609030808--
