Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbSJQKNM>; Thu, 17 Oct 2002 06:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbSJQKNM>; Thu, 17 Oct 2002 06:13:12 -0400
Received: from tailtiu.davidcoulson.net ([194.159.156.4]:19072 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id <S261300AbSJQKNG>; Thu, 17 Oct 2002 06:13:06 -0400
Message-ID: <3DAE8EEA.4080804@davidcoulson.net>
Date: Thu, 17 Oct 2002 11:20:26 +0100
From: David Coulson <david@davidcoulson.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020915
X-Accept-Language: en-gb
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, wstearns@posbox.com,
       linux-kernel@vger.kernel.org,
       UML devel <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [uml-devel] Re: swap_dup/swap_free errors with 2.4.20-pre10
References: <200210170202.VAA05667@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> I've seen this bug multiple times.  Basically, something is holding a
> mm_sem and not letting go.  Anything that walks the process list hangs.
> Ultimately, this hangs anything that's remotely useful, and you have to
> crash the box.

Indeed. I experienced the problem every 24-36hrs around five times in a 
row last week. Pretty much every morning, I'd come in and the box was 
completly dead. It seems to be okay at the moment, but I'm not holding 
my breath.

> One factoid that I forgot to mention there is that when it happens on my 
> laptop, the disk activity light is stuck on.

My box doesn't have a light, but what I got from SNMP before the box 
died suggested that the system (e.g. the 'system' CPU usage MIB) was 
using a considerable amount of CPU time (>95%), so I'm not sure if it 
was swapping madly, or if something else was going on.

David

-- 
David Coulson                                  http://davidcoulson.net/
d@vidcoulson.com                       http://journal.davidcoulson.net/

