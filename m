Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288432AbSAHVqQ>; Tue, 8 Jan 2002 16:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288402AbSAHVqH>; Tue, 8 Jan 2002 16:46:07 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:43205 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S288427AbSAHVpy> convert rfc822-to-8bit; Tue, 8 Jan 2002 16:45:54 -0500
Message-ID: <13FCCC1F3509D411B1C700A0C969DEBB05E20C2C@fmsmsx91.fm.intel.com>
From: "Gonzalez, Inaky" <inaky.gonzalez@intel.com>
To: "'Daniel Phillips'" <phillips@bonn-fries.net>,
        Andrew Morton <akpm@zip.com.au>
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: RE: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 8 Jan 2002 13:45:35 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And while I'm enumerating differences, the preemptable kernel 
> (in this 
> incarnation) has a slight per-spinlock cost, while the 
> non-preemptable kernel 
> has the fixed cost of checking for rescheduling, at intervals 
> throughout all 
> 'interesting' kernel code, essentially all long-running 
> loops. 

For a general case, that cost is leveraged by the improvement in scheduling,
by filling out the IO channels better, and thus, using most resources more
efficiently. I did some dirty tests that showed that the preemptible kernel
performed more or less one second better than the normal one when unzipping
and compiling a kernel [dirty general case]. The std deviation is around the
time difference, so we can quite conclude the impact is zero -- asides from
the improvement in responsiveness].

Please see my message to the mailing list at
http://www.geocrawler.com/archives/3/14905/2001/11/0/7074067/ [the excel
spreadsheet is available at request].

Iñaky Pérez González -- (503) 677 6807
I do not speak for Intel Corp, opinions are my own.
