Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132618AbRDYVuf>; Wed, 25 Apr 2001 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132629AbRDYVu0>; Wed, 25 Apr 2001 17:50:26 -0400
Received: from jalon.able.es ([212.97.163.2]:22976 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132618AbRDYVuI>;
	Wed, 25 Apr 2001 17:50:08 -0400
Date: Wed, 25 Apr 2001 23:50:00 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: tim@tjansen.de, linux-kernel@vger.kernel.org
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
Message-ID: <20010425235000.A3432@werewolf.able.es>
In-Reply-To: <01042522404901.00954@cookie> <200104252116.QAA46520@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200104252116.QAA46520@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Wed, Apr 25, 2001 at 23:16:10 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.25 Jesse Pollard wrote:
> 
> Alternatively, you can always put one value per record:
> 	tag:value
> 	tag2:value2...
> 
> This is still simpler than XML to read, and to generate.
> 

Just my two cents.

It looks clear that /proc is for programs, not for humans. So the best format
for proc is just binary values. So programs can read it quickly, even in
a chunk if they know the format. But sometimes it is usefull to do a cat on
a /proc entry.

Question: it is possible to redirect the same fs call (say read) to different
implementations, based on the open mode of the file descriptor ? So, if
you open the entry in binary, you just get the number chunk, if you open
it in ascii you get a pretty printed version, or a format description like
Bus: %d
Device: %h
..
to 'vprintf' the values.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac14 #1 SMP Wed Apr 25 02:07:45 CEST 2001 i686

