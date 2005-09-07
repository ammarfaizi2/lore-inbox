Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVIGQhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVIGQhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVIGQhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:37:52 -0400
Received: from venezia.uab.es ([158.109.168.132]:4044 "EHLO venezia.uab.es")
	by vger.kernel.org with ESMTP id S1751241AbVIGQhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:37:51 -0400
Date: Wed, 07 Sep 2005 18:38:08 +0200
From: =?UTF-8?B?TcOgcml1cyBNb250w7Nu?= <Marius.Monton@uab.es>
Subject: Re: 'virtual HW' into kernel (SystemC)
In-reply-to: <BFECAF9E178F144FAEF2BF4CE739C66801B76517@exmail1.se.axis.com>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <431F1770.3030603@uab.es>
Organization: Cephis-UAB
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_3KmpwErb3mhgNnHPYGMptw)"
X-Accept-Language: ca, es
X-Enigmail-Version: 0.92.0.0
References: <BFECAF9E178F144FAEF2BF4CE739C66801B76517@exmail1.se.axis.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-OriginalArrivalTime: 07 Sep 2005 16:38:36.0188 (UTC)
 FILETIME=[97D2FDC0:01C5B3CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_3KmpwErb3mhgNnHPYGMptw)
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8BIT



Mikael Starvik wrote:

>>Application <-> our driver <-> kernel PCI-subsystem <-> our link <-> 
>>daemon <-> SystemC simulator. 
>>    
>>
>
>  
>
>>Our link and our daemon get all PCI communication, and interface to 
>>SystemC simulator. 
>>Is that so complex to develop? 
>>    
>>
>
>No, not really. I've implemented a link like this
>
>Application<->driver<->our link<->daemon<-TCP/IP->glue<->Verilog simulator
>
>In your case I would probably implement a "fake" PCI bridge that forwards any PCI access to you daemon and puts the requesting process to sleep until the request has been processed. Some drivers may of course break due to the latency. 
>
>Our link is a kernel module that queues up requests from the driver and deliver them to the daemon through a poll/read interface. Each process that make a request is put to sleep until the request has been answered by the dameon. A couple of days of development. A bit more in your case due to the fake PCI bridge (yes, I have implemented one of those as well for cardbus).
>
>Regards
>/Mikael
>
>  
>

Can you send me or post your code?
This code can be a good starting point for us.

Thanks

Màrius

> 
>
>  
>


--Boundary_(ID_3KmpwErb3mhgNnHPYGMptw)
Content-type: text/x-vcard; charset=utf-8; name=marius.monton.vcf
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=marius.monton.vcf

begin:vcard
fn;quoted-printable:M=C3=A0rius Mont=C3=B3n
n;quoted-printable;quoted-printable:Mont=C3=B3n;M=C3=A0rius
org;quoted-printable:UAB;Departament de Microelectr=C3=B2nica i Sistemes Electr=C3=B2nics
adr:Campus de la UAB;;QC-2088 ETSE;Bellaterra;Barcelona;08193;SPAIN
email;internet:marius.monton@uab.es
tel;work:+34935813534
x-mozilla-html:TRUE
url:http://cephis.uab.es
version:2.1
end:vcard


--Boundary_(ID_3KmpwErb3mhgNnHPYGMptw)--
